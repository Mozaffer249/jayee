class DriversLocation {
  double? distance;
  String? applicationUserId;
  double? providerLatitude;
  double? providerLongitude;
  double? otherLatitude;
  double? otherLongitude;

  DriversLocation(
      {this.distance,
        this.applicationUserId,
        this.providerLatitude,
        this.providerLongitude,
        this.otherLatitude,
        this.otherLongitude});

  DriversLocation.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    applicationUserId = json['applicationUserId'];
    providerLatitude = json['providerLatitude'];
    providerLongitude = json['providerLongitude'];
    otherLatitude = json['otherLatitude'];
    otherLongitude = json['otherLongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['applicationUserId'] = this.applicationUserId;
    data['providerLatitude'] = this.providerLatitude;
    data['providerLongitude'] = this.providerLongitude;
    data['otherLatitude'] = this.otherLatitude;
    data['otherLongitude'] = this.otherLongitude;
    return data;
  }
}
