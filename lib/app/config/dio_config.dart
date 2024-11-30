import 'package:dio/dio.dart';
import 'package:taxi_app/app/config/auth_inteceptor.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';

class DioClient {
  static Dio get DIO_CLIENT {
    BaseOptions _baseOptions = BaseOptions(
        receiveTimeout: Duration(milliseconds: 50000),
        connectTimeout: Duration(milliseconds: 50000), //receiveDataWhenStatusError: true,
        followRedirects: false,
        contentType:"application/json" ,
        headers: {
          "Content-Type": "application/json",
          "lang":CommonVariables.langCode.read(LANG_CODE),
        },
     validateStatus: (status) {return status != null;} ,
        baseUrl:CommonVariables.settings.read(BASE_URL)
    );

    Dio _dio = Dio(_baseOptions);
    _dio.interceptors.add(AuthInterceptor());
    return _dio;
  }
}
