import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taxi_app/app/config/dio_config.dart';
import 'package:taxi_app/app/data/models/payment_card.dart';

class CustomerCardsProvider{

  static Future<Either<List<PaymentCard>, String?>>  getPaymentCards() async {
    try {
      var response = await DioClient.DIO_CLIENT.get(
        'customer/identity/GetPaymentCards',
      );
      if (response.statusCode == 200) {
        var paymentCardList = (response.data as List).map((e) => PaymentCard.fromJson(e)).toList();
        return left(paymentCardList);
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");

    } on DioException {
      return right("connection error");
    } on Exception {
      return right("connection error");
    }
  }
  static Future<Either<bool, String?>> deleteCard({int? cardId})async {
    try {
      var response = await DioClient.DIO_CLIENT.delete(
        'MoayserPayment/DeleteCard/$cardId',
      );
      if (response.statusCode == 200) {
        return left(response.data["returnData"]);
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      if (response.statusCode == 404) {
        return right(response.data["errorMessage"]);
      }
      return right("Connection error");
    } on DioException {
      return right("connection error");
    } on Exception {
      return right("connection error");
    }
  }
}