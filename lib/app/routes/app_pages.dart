
import 'package:get/get.dart';
import 'package:taxi_app/app/module/add_payment_card/binding/add_payment_card_binding.dart';
import 'package:taxi_app/app/module/home/bindings/home_binding.dart';
import 'package:taxi_app/app/module/setting/view/add_complaint_view.dart';
 import 'package:taxi_app/app/module/home/views/main_view.dart';
import 'package:taxi_app/app/module/home/views/search_place_view.dart';
import 'package:taxi_app/app/module/home/views/select_destination.dart';
import 'package:taxi_app/app/module/home/views/select_origin_view.dart';
import 'package:taxi_app/app/module/home/views/home_view.dart';
import 'package:taxi_app/app/module/home/views/select_trip_details.dart';
import 'package:taxi_app/app/module/login/bindings/login_binding.dart';
import 'package:taxi_app/app/module/login/views/login_view.dart';
import 'package:taxi_app/app/module/login/views/verify_otp_view.dart';
import 'package:taxi_app/app/module/notifications/binding/notification_binding.dart';
import 'package:taxi_app/app/module/notifications/view/notification_view.dart';
import 'package:taxi_app/app/module/setting/binding/setting_binding.dart';
import 'package:taxi_app/app/module/setting/view/complaint_details.dart';
import 'package:taxi_app/app/module/setting/view/complaint_list.dart';
import 'package:taxi_app/app/module/setting/view/coupons.dart';
import 'package:taxi_app/app/module/setting/view/invite_friend.dart';
import 'package:taxi_app/app/module/setting/view/langauge_change.dart';
import 'package:taxi_app/app/module/setting/view/profil.dart';
import 'package:taxi_app/app/module/setting/view/setting_view.dart';
import 'package:taxi_app/app/module/splash/bindings/splash_binding.dart';
import 'package:taxi_app/app/module/splash/views/splash_view.dart';
import 'package:taxi_app/app/module/start/bindings/start_binding.dart';
import 'package:taxi_app/app/module/start/views/start_view.dart';
import 'package:taxi_app/app/module/wallet/bindings/wallet_binding.dart';
import 'package:taxi_app/app/module/wallet/views/add_to_wallet.dart';
import 'package:taxi_app/app/module/wallet/views/add_to_wallet_web_view.dart';
import 'package:taxi_app/app/module/wallet/views/card_details.dart';
import 'package:taxi_app/app/module/wallet/views/my_cards.dart';
import 'package:taxi_app/app/module/wallet/views/save_payment_card_view.dart';
import 'package:taxi_app/app/module/wallet/views/select_card_type.dart';
import 'package:taxi_app/app/module/wallet/views/wallet_view.dart';

import '../module/my_trip/binding/my_trip_binding.dart';
import '../module/my_trip/views/my_trip_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.START,
      page: () => StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP_LOGIN,
      page: () => VerifyOtpLoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PLACE,
      page: () => SearchPlaceView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.SELECT_ORIGIN,
      page: () => SelectOriginView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAYMENT_CARD,
      page: () => SavePaymentCardView(),

      binding: AddPaymentCardBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_DESTINATION,
      page: () => SelectDestinationView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_TRIP_DETAILS,
      page: () => SelectTripDetailsView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_TRIP,
      page: () => MyTripView(),
      binding: MyTripBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TO_WALLET_WEB_VIEW,
      page: () => AddToWalletWebView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.Language_CHANGE,
      page: () => LangaugeChangeView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.INVITE_FRIEND,
      page: () => InviteFriendView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.DISCOUNT_COUPON,
      page: () => CouponsView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_COMPLAINT,
      page: () => AddComplaintView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.COMPLAINT_LIST,
      page: () => ComplaintListView(),
      binding: SettingBinding(),
    ),  GetPage(
      name: _Paths.COMPLAINT_DETAILS,
      page: () => ComplaintDetailsView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TO_WALLET,
      page: () => AddToWalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => SelectCardTypeView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_CARD_DETAILS,
      page: () => CardDetailsView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.SAVE_PAYMENT_CARD,
      page: () => SavePaymentCardView(),
      binding: WalletBinding(),
    ),

    //

    GetPage(
      name: _Paths.MY_CARDS,
      page: () => MyCardsView(),
      binding: WalletBinding(),
    ),

    // GetPage(
    //   name: _Paths.RESET_PASWORD,
    //   page: () => ResetPassword(),
    //   binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PASSWORD_SETED,
    //   page: () => PasswordSettedView(),
    //   binding: LoginBinding(),
    // ),
    //
    // GetPage(
    //   name: _Paths.SIGN_UP_MAIN,
    //   page: () => SignUpMainView(),
    //   binding: SignUpBinding(),
    // ),
    //
    //
    // GetPage(
    //   name: _Paths.SIGN_UP,
    //   page: () => SignUpView(),
    //   binding: SignUpBinding(),
    // ),
    //
    //
    // GetPage(
    //   name: _Paths.VERIFY_OTP_LOGIN,
    //   page: () => VerifyOtpLoginView(),
    //   binding: LoginBinding(),
    // ),
    //
    //


  ];
}