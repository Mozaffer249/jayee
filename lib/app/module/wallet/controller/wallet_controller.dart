import 'package:get/get.dart';
import 'package:taxi_app/app/data/models/custumer_transaction.dart';
import 'package:taxi_app/app/data/models/payment_card.dart';
import 'package:taxi_app/app/provider/customer/wallet/customer_cards_provider.dart';
import 'package:taxi_app/app/provider/customer/wallet/wallet_transaction.dart';
import 'package:taxi_app/app/utils/dialog_utils.dart';

class WalletController extends GetxController{

  var amountToAdd=30.obs;
  var selectedPaymentMethod = 'creditCard'.obs;

  final RxBool _isRemovingCard = false.obs;
  bool get isRemovingCard => _isRemovingCard.value;

  final RxBool _isLoadingyMyCard = true.obs;
  bool get isLoadingyMyCard => _isLoadingyMyCard.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  RxList<PaymentCard> _paymentCards = <PaymentCard>[].obs;
  List<PaymentCard> get paymentCards => _paymentCards.value;

  Rx<PaymentCard> _selectedPaymentCard = PaymentCard().obs;
  set selectedPaymentCard(PaymentCard value) {
    _selectedPaymentCard.value = value;
  }
  Rx<CustomerTransaction> customerTransaction=CustomerTransaction().obs;
  RxDouble walletSum=0.0.obs;

   final RxString url ="".obs;
  @override
  void onInit() {
    getCustomerWallet();
    getPaymentCards();
     super.onInit();
  }
  Future<void>getCustomerWallet()async{
    _isLoading(true);
    final result=await WalletTransaction.getWalletTransactions();
    result.fold((l){
      customerTransaction.value=l;
       getWalletSum();
    }, (r){
    });
  }
  Future<void>getWalletSum()async{
    final result=await WalletTransaction.getWalletSum();
   _isLoading(false);
    result.fold((l){
      walletSum.value=l;
      update();
    }, (r){
    });
  }
  Future<void> getPaymentCards() async {
    _isLoadingyMyCard(true);
    final result = await CustomerCardsProvider.getPaymentCards();
    _isLoadingyMyCard(false);
    result.fold((l) {
      _paymentCards(l);
      if (_paymentCards.length != 0) {
        _selectedPaymentCard.value = _paymentCards.value.first;
      }
      update();
    }, (r) {
      print(r);
    });
  }
  Future<void> deleteCards({int? cardId}) async {
    _isRemovingCard(true);
    final result = await CustomerCardsProvider.deleteCard(cardId:cardId);
    _isRemovingCard(false);
    result.fold((l) {
      _paymentCards.removeWhere((paymentCard) => paymentCard.id == cardId);
      _paymentCards.refresh();
       update();
    }, (r) {
      showSnackbar(title: "", message:r!);
    });
  }
}


