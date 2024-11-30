class CarClass {
  int? id;
  String? name;
  String? nameAr;
  String? icon;
  double? distance;
  double? offerPrice;

  CarClass({this.id, this.name, this.nameAr, this.icon, this.distance, this.offerPrice});

  CarClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['nameAr'];
    icon = json['icon'];
    distance = json['distance'];
    offerPrice = json['offerPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['NameAr'] = this.nameAr;
    data['Icon'] = this.icon;
    data['Distance'] = this.distance;
    data['price'] = this.offerPrice;
    return data;
  }
}
