import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/app/config/dio_config.dart';
import 'package:taxi_app/app/data/models/car_class.dart';
import 'package:taxi_app/app/data/models/drivers_location.dart';
import 'package:taxi_app/app/data/models/order_details.dart';
import 'package:taxi_app/app/data/models/place.dart';
import 'package:taxi_app/app/data/models/user_order.dart';

class OrderProvider {
  static Future<Either<List<CarClass>, String>> getCarClassWithPrice(
      {LatLng? origin, LatLng? destination}) async {
    try {
      final response = await DioClient.DIO_CLIENT.post(
        "CarClass/GetCarClassesWithPrices"
        , data: {
        "orderLongitude": "${destination!.longitude}",
        "orderLatitude": "${destination.latitude}",
        "customerLongitude": "${origin!.longitude}",
        "customerLatitude": "${origin.latitude}"
      },
      );
      if (response.statusCode == 200) {
        var carsClassList = (response.data["returnData"] as List).map((e) =>
            CarClass.fromJson(e)).toList();
        return left(carsClassList);
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right("Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

  static Future<Either<List<Place>, String>> getCustomerPreviousTaxiLocations() async
  {
    try {
      final response = await DioClient.DIO_CLIENT.get(
          "Customer/GetCustomerPreviousTaxiLocations");
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = response.data;
        if (result.containsKey('isSucceeded') &&
            result['isSucceeded'] == true) {
          var places = (response.data["returnData"] as List).map((e) =>
              Place.fromJson(e)).toList();
          return left(places);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right("Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

  static Future<Either<List<UserOrder>, String>>  getMyOrders({String? status}) async
  {
    try {
      final response = await DioClient.DIO_CLIENT.get(
          "TransportOrder/orders/customer/${status}");
      if (response.statusCode == 200) {
          var orders = (response.data as List).map((e) => UserOrder.fromJson(e)).toList();
          return left(orders);
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right("Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

  static Future<Either<List<DriversLocation>, String>>GetNearProviderToCustomer({double? lat, double? lng})async{

    try{
      final response = await DioClient.DIO_CLIENT.get("TransportOrder/GetNearProviderToCustomer/$lat/$lng");
      if (response.statusCode == 200) {
         var places = (response.data as List).map((e)=>DriversLocation.fromJson(e)).toList();
         return left(places);
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right("Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }
  static Future<Either<int, String>> addOrder({required Map<String, dynamic> data}) async {
    try {
      final response = await DioClient.DIO_CLIENT.post(
          "TransportOrder/order", data: data);
      if (response.statusCode == 200) {
        if (response.data['isSucceeded'] == true) {
          return left(response.data['returnData']);
        }
        else {
          return right(response.data['errorMessage']);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
   catch (_) {
      return right(_.toString());
    }
  }
  static Future<Either<bool, String>> cancelOrderCustomer({int? orderId}) async {
    try {
      final response = await DioClient.DIO_CLIENT.post(
          "TransportOrder/cancel/$orderId/customer");
      if (response.statusCode == 200) {
        if (response.data['isSucceeded'] == true) {
          return left(true);
        }
        else {
          return right(response.data['errorMessage']);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
   catch (_) {
      return right(_.toString());
    }
  }
static Future<Either<List<int>, String>> getOpenOrdersIds( ) async {
    try {
      final response = await DioClient.DIO_CLIENT.get("TransportOrder/GetOpenOrdersIds");
      if (response.statusCode == 200) {
        if (response.data['isSucceeded'] == true) {
          var orders = (response.data["returnData"] as List<dynamic>).cast<int>().toList();

          return left(orders);
        }
        else {
          return right(response.data['errorMessage']);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right("Connection error");
    }
    on Exception catch (_) {
      return right("Connection error");
    }
}
static Future<Either<OrderDetails, String>>getTransportOrderById({int? id})async{
  try{
    final response = await DioClient.DIO_CLIENT.get("TransportOrder/Customer/GetTransportOrderById/$id");
    if (response.statusCode == 200) {
      if (response.data['isSucceeded'] == true) {
        final orderDetais=OrderDetails.fromJson(response.data['returnData']);
        return left(orderDetais);
      }
      else {
        return right(response.data['errorMessage']);
      }
    }
    if (response.statusCode == 401) {
      return right("Unauthorized");
    }
    return right("Connection error");
  }
  on DioException {
    return right("Connection error");
  }
  on Exception catch (_) {
    return right("Connection error");
  }
}
  static Future<Either<bool, String>> recurringPayments({double? amount, String? token, int? orderId,})async
  {
    try{
      final response = await DioClient.DIO_CLIENT.post(
          "MoayserPayment/RecurringPayments",
      data: {
        "amount":  amount,
        "token": token,
        "orderId": orderId ,
        "orderType": 2
      }
      );
      if (response.statusCode == 200) {
        if (response.data['isSucceeded'] == true) {
          return left(true);
        }
        else {
          return right(response.data['errorMessage']);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      if (response.statusCode == 404) {
        return right("Card Not Found");
      }
      return right("Connection error");
    }
    catch (_) {
      return right(_.toString());
    }
  }
  // var  drivers=[
  //   {
  //     "latitude": 24.830120,
  //     "longitude": 46.794200
  //   },
  //   {
  //     "latitude": 24.829300,
  //     "longitude": 46.792500
  //   },
  //   {
  //     "latitude": 24.827500,
  //     "longitude": 46.793800
  //   },
  //   {
  //     "latitude": 24.829800,
  //     "longitude": 46.796100
  //   },
  //   {
  //     "latitude": 24.828900,
  //     "longitude": 46.795000
  //   },
  //   {
  //     "latitude": 24.827200,
  //     "longitude": 46.791900
  //   },
  //   {
  //     "latitude": 24.830500,
  //     "longitude": 46.795300
  //   },
  //   {
  //     "latitude": 24.826800,
  //     "longitude": 46.794400
  //   },
  //   {
  //     "latitude": 24.831100,
  //     "longitude": 46.792100
  //   },
  //   {
  //     "latitude": 24.827900,
  //     "longitude": 46.792800
  //   }
  // ];

}
