class Cobon {
  int? id;
  String? coboneCode;
  String? expiryDate;
  double? amount;
  int? shopId;
  String? createAt;
  bool? isActive;
  int? limitation;
  int? numberOfUse;
  String? note;
  double? maxPercentageValue;
  int? coboneType;
  int? orderType;

  Cobon(
      {this.id,
        this.coboneCode,
        this.expiryDate,
        this.amount,
        this.shopId,
        this.createAt,
        this.isActive,
        this.limitation,
        this.numberOfUse,
        this.note,
        this.maxPercentageValue,
        this.coboneType,
        this.orderType});

  Cobon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coboneCode = json['coboneCode'];
    expiryDate = json['expiryDate'];
    amount = json['amount'];
    shopId = json['shopId'];
    createAt = json['createAt'];
    isActive = json['isActive'];
    limitation = json['limitation'];
    numberOfUse = json['numberOfUse'];
    note = json['note'];
    maxPercentageValue = json['maxPercentageValue'];
    coboneType = json['coboneType'];
    orderType = json['orderType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coboneCode'] = this.coboneCode;
    data['expiryDate'] = this.expiryDate;
    data['amount'] = this.amount;
    data['shopId'] = this.shopId;
    data['createAt'] = this.createAt;
    data['isActive'] = this.isActive;
    data['limitation'] = this.limitation;
    data['numberOfUse'] = this.numberOfUse;
    data['note'] = this.note;
    data['maxPercentageValue'] = this.maxPercentageValue;
    data['coboneType'] = this.coboneType;
    data['orderType'] = this.orderType;
    return data;
  }
}
