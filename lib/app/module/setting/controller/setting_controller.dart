
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/models/suggestion.dart';
import 'package:taxi_app/app/data/models/suggestion_and_replies.dart';
import 'package:taxi_app/app/module/auth/controllers/auth_controller.dart';
import 'package:taxi_app/app/provider/app/app_provider.dart';
import 'package:taxi_app/app/provider/customer/identity/customer_identity.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:taxi_app/app/utils/dialog_utils.dart';
import 'package:taxi_app/app/utils/file_utils.dart';

class SettingController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> resetFormKey = GlobalKey();
  final AuthController authController = Get.find<AuthController>();

  TextEditingController fullNameConrtoller = TextEditingController();
  TextEditingController mobileConrtoller = TextEditingController();
  TextEditingController emailConrtoller = TextEditingController();
  TextEditingController profilePictureConrtoller = TextEditingController();

  TextEditingController suggestionConrtoller = TextEditingController();
  TextEditingController complaintTitleConrtoller = TextEditingController();
  TextEditingController complaintBodyConrtoller = TextEditingController();

  RefreshController refreshController = RefreshController(initialRefresh: false);



  final RxBool _isSendingReply = false.obs;
  bool get isSendingReply => _isSendingReply.value;

  final RxBool _isReLoading = false.obs;
  RxBool get isReLoading => _isReLoading;

  final RxBool _isLoadingSuggestions = true.obs;
  bool get isLoadingSuggestions => _isLoadingSuggestions.value;
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  var imageUrl = ''.obs;
  var profilePicturePath = ''.obs;
  var fromStart =false.obs;

  RxList<Suggestion> _suggestions=<Suggestion>[].obs;
  RxList<Suggestion> get suggestions => _suggestions;

  Rx<SuggestionAndReplies>_suggestionAndReplies=SuggestionAndReplies().obs;
  Rx<SuggestionAndReplies>get suggestionAndReplies=>_suggestionAndReplies;

  @override
  void onInit() {
    if(Get.arguments != null)fromStart.value=true;
    initProfile();
    getSuggestions();
    super.onInit();
  }

  Future<void>initProfile()async{
    final user=authController.currentUser ;
    mobileConrtoller.text=user!.phoneNumber ??"";
    fullNameConrtoller.text=user.fullname ??"";
    emailConrtoller.text=user.email ??"";
    imageUrl.value =user.imagePath ??"";
    _isLoading(false);
  }

  Future<void>updataProfile()async{
    if (!formKey.currentState!.validate()) {
      return;
    }

    if(profilePicturePath.value != "")
    {
      await updataProfileImage();
    }
    _isReLoading(true);
    final result=await CustomerIdentity.updateProfile(
        email: emailConrtoller.text.trim(),
        fullName: fullNameConrtoller.text.trim(),
        birthDate: authController.currentUser!.birthDate!,
        gender:  authController.currentUser!.gender!);
       _isReLoading(false);
    result.fold((l)async{
    await  getProfile();
    }, (r){

    });
  }

  Future<void>updataProfileImage()async{
    _isReLoading(true);
    final result=await CustomerIdentity.updateProfileImage(imagePath: profilePicturePath.value);
       _isReLoading(false);
    result.fold((l){

    }, (r){
    });
  }

  Future<void>getProfile()async{
    _isReLoading(true);
    final result=await CustomerIdentity.getProfile();
    _isReLoading(false);
    result.fold((l){
      authController.currentUser=l;
      CommonVariables.userData.write("userData", authController.currentUser!.toJson());
      update();
      fromStart.value ?Get.offAllNamed(Routes.MAIN):Get.back();
    }, (r){

    }
    );
  }
  Future<void> pickImage() async {
    final picker = pickFile(Get.overlayContext!);
    final pickedFile = await picker;
    if (pickedFile != null) {
      profilePicturePath.value = pickedFile.path;
      update();
      print("***********${pickedFile.path}");
      print("***********${profilePicturePath.value}");

    }
  }

  Future<void> getSuggestions()async{
    _isLoadingSuggestions(true);
    final result=await AppProvider.getSuggestionList();
      _isLoadingSuggestions(false);

      result.fold((l){
         _suggestions(l);
          update();
      }, (r){

      });
  }
  Future<void> getSuggestionById({int? id})async{
    _isReLoading(true);
    final result=await AppProvider.getSuggestById(Id: id!);
    _isReLoading(false);
      result.fold((l){
        _suggestionAndReplies(l);
        update();
        Get.toNamed(Routes.COMPLAINT_DETAILS);
      }, (r){
        showSnackbar(title: "", message: "${r!.tr}");
      });
  }
  Future<void>addReply()async{

    _isSendingReply(true);
     final result=await AppProvider.addReply(
       reply: suggestionConrtoller.text.trim(),
       suggestionId: _suggestionAndReplies.value.id
     );
    _isSendingReply(false);

    result.fold((l)async{
       suggestionConrtoller.clear();
       _suggestionAndReplies.value.replies!.add(
         new Replies(
              id: l["generalSuggestId"],
              replyUserName: authController.currentUser!.fullname!,
              isFromAdmin: false,
              message: l["message"],
              createAt: DateTime.now().toString(),
       ));
        update();
     }, (r){
       showSnackbar(title: "", message: r!);
     });
   }
   Future<void>addComplaint()async{
     if( complaintTitleConrtoller.text.isEmpty){
       showSnackbar(title: "", message: "عنوان الشكوى مطلوب");
       return;
     }
     else if(complaintBodyConrtoller.text.isEmpty){
       showSnackbar(title: "", message: "نص الشكوى مطلوب");
       return;
     }
     _isReLoading(true);
     final result=await AppProvider.addComplaint(
       title: complaintTitleConrtoller.text,
       body: complaintTitleConrtoller.text
     );
     _isReLoading(false);

     result.fold((l)async{
       complaintTitleConrtoller.clear();
       complaintBodyConrtoller.clear();
       Get.back(result: true);
       Get.snackbar("", "تم الارسال بنجاح");
       update();
     }, (r){
       showSnackbar(title: "", message: r!);
     });
   }
}



