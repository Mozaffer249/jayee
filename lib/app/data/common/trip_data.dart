import 'package:taxi_app/app/data/models/trip.dart';

var  dummyTrips =   <TripInfo>[
   TripInfo(
      status: "current",
      pickupLocation: 'La Centre',
      destLocation: 'Louis Vuitton',
      date: "4/April/2018",
      time: '3:30 PM',
      payBy: "Cash",

     amount: 50,
     finalAmount: 40,


  ),
   TripInfo(
     status: "cancled",
     pickupLocation: 'La Centre',
      destLocation: 'Louis Vuitton',
      date: "4 /April/2018",
      time: '3:30 PM',
      payBy: "Visa",
     amount: 50,
     finalAmount: 40,

  ),
   TripInfo(
     status: "ended",
     pickupLocation: 'La Centre',
      destLocation: 'Louis Vuitton',
      date: "4/April/2018",
      time: '3:30 PM',
      payBy: "Visa",
     amount: 50,
     finalAmount: 40,
  ),
];