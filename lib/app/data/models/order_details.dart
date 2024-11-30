class OrderDetails {
  int? id;
  double? orderLatitude;
  double? orderLongitude;
  String? orderDescriptionLocation;
  double? customerLatitude;
  double? customerLongitude;
  String? customerDescriptionLocation;
  double? distance;
  double? orderAmount;
  int? statues;
  String? statusString;
  String? statusStringAr;
  ProviderData? providerData;

  OrderDetails(
      {this.id,
        this.orderLatitude,
        this.orderLongitude,
        this.orderDescriptionLocation,
        this.customerLatitude,
        this.customerLongitude,
        this.customerDescriptionLocation,
        this.distance,
        this.orderAmount,
        this.statues,
        this.statusString,
        this.statusStringAr,
        this.providerData});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderLatitude = json['orderLatitude'];
    orderLongitude = json['orderLongitude'];
    orderDescriptionLocation = json['orderDescriptionLocation'];
    customerLatitude = json['customerLatitude'];
    customerLongitude = json['customerLongitude'];
    customerDescriptionLocation = json['customerDescriptionLocation'];
    distance = json['distance'];
    orderAmount = json['orderAmount'];
    statues = json['statues'];
    statusString = json['statusString'];
    statusStringAr = json['statusStringAr'];
    providerData = json['providerData'] != null
        ? new ProviderData.fromJson(json['providerData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderLatitude'] = this.orderLatitude;
    data['orderLongitude'] = this.orderLongitude;
    data['orderDescriptionLocation'] = this.orderDescriptionLocation;
    data['customerLatitude'] = this.customerLatitude;
    data['customerLongitude'] = this.customerLongitude;
    data['customerDescriptionLocation'] = this.customerDescriptionLocation;
    data['distance'] = this.distance;
    data['orderAmount'] = this.orderAmount;
    data['statues'] = this.statues;
    data['statusString'] = this.statusString;
    data['statusStringAr'] = this.statusStringAr;
    if (this.providerData != null) {
      data['providerData'] = this.providerData!.toJson();
    }
    return data;
  }
}

class ProviderData {
  String? provderId;
  String? fullName;
  String? phoneNumber;
  String? profileImage;

  ProviderData({this.fullName, this.phoneNumber, this.profileImage});

  ProviderData.fromJson(Map<String, dynamic> json) {
    provderId = json['providerUserId'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
