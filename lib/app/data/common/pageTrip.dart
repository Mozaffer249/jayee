class PageTrip {
  PageTrip({ required this.label });
  final String label;
  String get id => label[0];
  @override
  String toString() => '$runtimeType("$label")';
}