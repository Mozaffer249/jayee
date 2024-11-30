import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taxi_app/app/data/models/user_model.dart';
import '../../../config/dio_config.dart';

class CustomerIdentity {
  static Future<Either<bool, String?>> login(String  phoneNumber) async {
    try {
      var response = await DioClient.DIO_CLIENT.get(
        'customer/identity/login/$phoneNumber',
      );

      if (response.data["isSucceeded"] != true) {
        return right("connection error");
      }

      final Map<String, dynamic> result = response.data;
      if (result.containsKey('isSucceeded') && result['isSucceeded'] == true) {
        return left(true);
      } else {
        return right("connection error");
      }

    } on DioException {
      return right("connection error");
    } on Exception {
      return right("connection error");
    }
  }

  static Future<Either<Map<String, dynamic>, String>> verifyOtpAndPhone({
    String? phoneNumber,
    String? otp,
  }) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        'customer/identity/login',
        data: {
          "otp": otp,
          "phoneNumber": phoneNumber,
          "latitude": 0,
          "longitude": 0,
          "referrerId": 0,
        },
        options: Options(
          validateStatus: (status) {
            return status != null;
          },
        ),
      );
      if (response.statusCode == 200) {
        return left(response.data);
      }

      if (response.statusCode == 400) {
        return right("${response.data["errorMessage"]}");
      }

      return right("Connection error");

    } on DioException {
      return right( "Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

  static Future<Either<AppUser, String>> getProfile() async{
    try{
      final response=await DioClient.DIO_CLIENT.get("customer/identity/getProfile",
        options: Options(
          validateStatus: (status) {
            return status != null;
          },
        ),
      );
      if (response.statusCode == 200) {
        var user=AppUser.fromJson(response.data['returnData']);
        return left(user);
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right( "Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

  static Future<Either<bool, String>> updateProfile(
  {
    required String email ,
    required String   fullName  ,
    required String  birthDate  ,
    required int  gender
}) async{
    try{
      final response=await DioClient.DIO_CLIENT.put("customer/identity/updateProfile",
        data: {
          "email":email,
          "fullName": fullName,
          "birthDate": birthDate,
          "gender": gender
        },
        options: Options(
          validateStatus: (status) {
            return status != null;
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = response.data;
        if (result.containsKey('isSucceeded') && result['isSucceeded'] == true) {
          return left(true);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right( "Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

  static Future<Either<bool, String>> updateProfileImage({imagePath}) async{

    final file = File(imagePath);
    final fileName = file.path.split('/').last;
    // Prepare FormData for the image upload
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try{
      final response=await DioClient.DIO_CLIENT.post("customer/identity/updateProfileImage",
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status != null;
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = response.data;
        if (result.containsKey('isSucceeded') && result['isSucceeded'] == true) {
          return left(true);
        }
      }
      if (response.statusCode == 401) {
        return right("Unauthorized");
      }
      return right("Connection error");
    }
    on DioException {
      return right( "Connection error");
    } on Exception catch (_) {
      return right("Connection error");
    }
  }

}