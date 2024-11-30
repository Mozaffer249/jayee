
import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/common/pageTrip.dart';
import 'package:taxi_app/app/data/models/trip.dart';

class TripListTabItem extends StatelessWidget {
  TripListTabItem({required this.page, required this.data });
  static const double height = 250.0;
  final PageTrip? page;
  final TripInfo data;
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // new TripListItem(trip: data,)
          ],
        ),
      ),
    );
  }
}