class TripOrder {
  int? id;
 double? orderLatitude;
 double? orderLongitude;
  String? orderDescriptionLocation;
  double? customerLatitude;
  double? customerLongitude;
  String? customerDescriptionLocation;
  String? bookingDate;
  int? customerId;
  var statues;
  int? orderType;
  int? payType;
  int? carClassId;
  int? gender;
  double? total;
  int? coboneId;
  double? coboneValue;
  List<String>? images;
  TripOrder(
      {this.id,
        this.orderLatitude,
        this.orderLongitude,
        this.orderDescriptionLocation,
        this.customerLatitude,
        this.customerLongitude,
        this.customerDescriptionLocation,
        this.bookingDate,
        this.customerId,
        this.statues,
        this.orderType,
        this.payType,
        this.carClassId,
        this.gender,
        this.total,
        this.coboneId,
        this.coboneValue,
        this.images});

  TripOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderLatitude = json['orderLatitude'];
    orderLongitude = json['orderLongitude'];
    orderDescriptionLocation = json['orderDescriptionLocation'];
    customerLatitude = json['customerLatitude'];
    customerLongitude = json['customerLongitude'];
    customerDescriptionLocation = json['customerDescriptionLocation'];
    bookingDate = json['bookingDate'];
    customerId = json['customerId'];
    statues = json['statues'];
    orderType = json['orderType'];
    payType = json['payType'];
    carClassId = json['carClassId'];
    gender = json['gender'];
    total = json['total'];
    coboneId = json['coboneId'];
    coboneValue = json['CoboneValue'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderLatitude'] = this.orderLatitude;
    data['orderLongitude'] = this.orderLongitude;
    data['orderDescriptionLocation'] = this.orderDescriptionLocation;
    data['customerLatitude'] = this.customerLatitude;
    data['customerLongitude'] = this.customerLongitude;
    data['customerDescriptionLocation'] = this.customerDescriptionLocation;
    data['bookingDate'] = this.bookingDate;
    data['customerId'] = this.customerId;
    data['statues'] = this.statues;
    data['orderType'] = this.orderType;
    data['payType'] = this.payType;
    data['carClassId'] = this.carClassId;
    data['gender'] = this.gender;
    data['total'] = this.total;
    data['coboneId'] = this.coboneId;
    data['CoboneValue'] = this.coboneValue;
    return data;
  }
}
