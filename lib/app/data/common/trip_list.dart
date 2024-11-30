import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/models/trip.dart';


class TripList extends StatelessWidget {

  final List<TripInfo> _trips;
  TripList(this._trips);

  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        // children: _buildList()
    );
  }

  // List<TripListItem> _buildList() {
  //   return _trips.map((contact) => new TripListItem(trip: contact,)).toList();
  // }

  int length(){
    return _trips.length;
  }
}
