class VehicleOption {
  final String price;
  final String type;
  final String distance;
  final String image;
  final String time;
  final bool isSelected;
  VehicleOption( {
    required this.price,
    required this.type,
    required this.distance,
    required this.time,
    required this.image,
    this.isSelected = false,
  });
}