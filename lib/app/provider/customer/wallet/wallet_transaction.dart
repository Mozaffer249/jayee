import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taxi_app/app/config/dio_config.dart';
import 'package:taxi_app/app/data/models/custumer_transaction.dart';

class WalletTransaction{

  static Future<Either<CustomerTransaction, String?>>  getWalletTransactions() async {
    try {
      var response = await DioClient.DIO_CLIENT.get(
        'CustomerWallet',
      );

      if (response.data["isSucceeded"] != true) {
        return right("connection error");
      }
      final Map<String, dynamic> result = response.data;
      if (result.containsKey('isSucceeded') && result['isSucceeded'] == true) {
        var customerTransaction=CustomerTransaction.fromJson(result["returnData"]);
        return left(customerTransaction );
      } else {
        return right("connection error");
      }
    } on DioException {
      return right("connection error");
    } on Exception {
      return right("connection error");
    }
  }
 static Future<Either<double, String?>>  getWalletSum() async {
    try {
      var response = await DioClient.DIO_CLIENT.get(
        'CustomerWallet/Sum',
      );
      if (response.data["isSucceeded"] != true) {
        return right("connection error");
      }
      final Map<String, dynamic> result = response.data;
      if (result.containsKey('isSucceeded') && result['isSucceeded'] == true) {
         return left(result['returnData']);
      } else {
        return right("connection error");
      }

    } on DioException {
      return right("connection error");
    } on Exception {
      return right("connection error");
    }
  }

}