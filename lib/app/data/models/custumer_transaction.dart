
class CustomerTransaction {
  double? totalAmount;
  List<CustomerWalletTransaction>? customerWalletTransaction;

  CustomerTransaction({this.totalAmount, this.customerWalletTransaction});

  CustomerTransaction.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    if (json['customerWalletDtos'] != null) {
      customerWalletTransaction = <CustomerWalletTransaction>[];
      json['customerWalletDtos'].forEach((v) {
        customerWalletTransaction!.add(new CustomerWalletTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    if (this.customerWalletTransaction != null) {
      data['customerWalletDtos'] =
          this.customerWalletTransaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerWalletTransaction {
  int? id;
  double? amount;
  int? type;
  int? walletActionType;
  int? customerId;
  String? createAt;
  String? note;
  int? transportOrderId;
  int? deliveryOrderId;
  bool? isApprovedByAdmin;
  String? moneyTransferImage;
  String? paymentId;

  CustomerWalletTransaction(
      {this.id,
        this.amount,
        this.type,
        this.walletActionType,
        this.customerId,
        this.createAt,
        this.note,
        this.transportOrderId,
        this.deliveryOrderId,
        this.isApprovedByAdmin,
        this.moneyTransferImage,
        this.paymentId});

  CustomerWalletTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    walletActionType = json['walletActionType'];
    customerId = json['customerId'];
    createAt = json['createAt'];
    note = json['note'];
    transportOrderId = json['transportOrderId'];
    deliveryOrderId = json['deliveryOrderId'];
    isApprovedByAdmin = json['isApprovedByAdmin'];
    moneyTransferImage = json['moneyTransferImage'];
    paymentId = json['paymentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['walletActionType'] = this.walletActionType;
    data['customerId'] = this.customerId;
    data['createAt'] = this.createAt;
    data['note'] = this.note;
    data['transportOrderId'] = this.transportOrderId;
    data['deliveryOrderId'] = this.deliveryOrderId;
    data['isApprovedByAdmin'] = this.isApprovedByAdmin;
    data['moneyTransferImage'] = this.moneyTransferImage;
    data['paymentId'] = this.paymentId;
    return data;
  }
}
