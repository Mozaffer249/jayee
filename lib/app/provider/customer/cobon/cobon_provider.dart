import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taxi_app/app/config/dio_config.dart';
import 'package:taxi_app/app/data/models/cobon.dart';

class CobonProvider {
  static Future<Either<Cobon, String>> checkCobon({String? code,int? shopBranchId ,double? orderAmount}) async {
    try {
      final response = await DioClient.DIO_CLIENT.get('Cobone/CheckCobone/$shopBranchId?code=$code&OrderAmount=$orderAmount&orderTypeEnum=2');
      if (response.statusCode == 200) {
       if(response.data['isSucceeded'] == true){
         return left(Cobon.fromJson(response.data['returnData']));
       }else{
         return right(response.data['errorMessage']);
       }
      }
      else if(response.statusCode == 401){
        return right("Unauthorized");
      }
      return right("Connection error");
  }
    on DioException  {
      return right( "Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }
}