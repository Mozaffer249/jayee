class UserOrder {
  int? id;
  String? date;
  String? dateAr;
  String? status;
  String? statusAr;
  String? orderAmount;
  String? orderDescriptionLocation;
  String? customerDescriptionLocation;

  UserOrder(
      {this.id,
        this.date,
        this.dateAr,
        this.status,
        this.statusAr,
        this.orderAmount,
        this.orderDescriptionLocation,
        this.customerDescriptionLocation});

  UserOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateAr = json['dateAr'];
    status = json['status'];
    statusAr = json['statusAr'];
    orderAmount = json['orderAmount'];
    orderDescriptionLocation = json['orderDescriptionLocation'];
    customerDescriptionLocation = json['customerDescriptionLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['dateAr'] = this.dateAr;
    data['status'] = this.status;
    data['statusAr'] = this.statusAr;
    data['orderAmount'] = this.orderAmount;
    data['orderDescriptionLocation'] = this.orderDescriptionLocation;
    data['customerDescriptionLocation'] = this.customerDescriptionLocation;
    return data;
  }
}
