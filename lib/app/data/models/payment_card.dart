class PaymentCard {
  int? id;
  String? token;
  String? cardLast4Digits;
  String? brand;
  String? applicationUserId;

  PaymentCard(
      {this.id,
        this.token,
        this.cardLast4Digits,
        this.brand,
        this.applicationUserId});

  PaymentCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    cardLast4Digits = json['cardLast4Digits'];
    brand = json['brand'];
    applicationUserId = json['applicationUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['cardLast4Digits'] = this.cardLast4Digits;
    data['brand'] = this.brand;
    data['applicationUserId'] = this.applicationUserId;
    return data;
  }
}
