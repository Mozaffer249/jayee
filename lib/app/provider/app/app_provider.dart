import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taxi_app/app/config/dio_config.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/models/suggestion.dart';
import 'package:taxi_app/app/data/models/suggestion_and_replies.dart';

class AppProvider{
  static Future<Either<List<Suggestion>, String?>> getSuggestionList()async{
    try {
      var response = await DioClient.DIO_CLIENT.get('App/GeneralSuggest/List');
      if(response.statusCode==200){
        if(response.data['data']!=null){
          var suggestion=(response.data['data'] as List).map((e) => Suggestion.fromJson(e)).toList();
          return left(suggestion);
         }
      }
      else if(response.statusCode==400){
        return right("connection error");
      }
      else if(response.statusCode==401){
        return right("Unauthorized");
      }
        return right("connection error");
  }
  on DioException {
    return right("connection error");
  }     catch (e) {
    return right("connection error");
  }
  }
  static Future<Either<SuggestionAndReplies,String?>> getSuggestById({int? Id})async{

    try {
      var response = await DioClient.DIO_CLIENT.get('App/GeneralSuggest/GetById/$Id');
      if(response.statusCode==200){
            return left(SuggestionAndReplies.fromJson(response.data));
      }
      else if(response.statusCode==400){
        return right("connection error");
      }
      else if(response.statusCode==401){
        return right("Unauthorized");
      }
      return right("connection error");
    }
    on DioException {
      return right("connection error");
    }    
    catch (e) {
      print(e);
      return right("connection errorssssssssssssssss");
    }
  }

  static Future<Either<Map<String,dynamic>,String?>>addReply({ int? suggestionId, String? reply})async{
    try {
         final response = await DioClient.DIO_CLIENT.post('App/GeneralSuggest/AddReply',
         data:{
           "message": reply,
           "generalSuggestId": suggestionId
         }
         );
         if(response.statusCode==200){
           return left(response.data);
          }
         else if(response.statusCode==400){
           return right(response.data);
         }
         else if(response.statusCode==401){
           return right("Unauthorized");
         }
         return right("connection error");
    }
    on DioException {
      return right("connection error");
    }     catch (e) {
      return right("connection error");
    }
    }

    static Future<Either<Map<String,dynamic>,String?>>addComplaint({String? title, String? body,})async{
      try {
         final response = await DioClient.DIO_CLIENT.post('App/GeneralSuggest/Add',
         data:{
           "title": title,
           "body": body,
          });
         if(response.statusCode==200){
            return left(response.data);
          }
         else if(response.statusCode==400){
           return right(response.data); ;
         }
         else if(response.statusCode==401){
           return right("Unauthorized");
         }
         return right("connection error");
    }
    on DioException catch (e) {
      return right(e.toString());
    }     catch (e) {
      return right(e.toString());
    }
    }
    static Future<Either<Map<String,dynamic>,String?>>updateFireBaseToken({String? token, String? frontEndDevice})async{
      try {
         final response = await DioClient.DIO_CLIENT.put('customer/identity/updateFirebaseToken',
         data:{
           "token": token,
           "favoriteLanguage":await CommonVariables.langCode.read(LANG_CODE),
           "frontEndDevice": frontEndDevice
          });
         if(response.statusCode==200){
            return left(response.data);
          }
         else if(response.statusCode==400){
           return right(response.data);
         }
         else if(response.statusCode==401){
           return right("Unauthorized");
         }
         return right("connection error");
    }
    on DioException catch (e) {
      return right(e.toString());
    }     catch (e) {
      return right(e.toString());
    }
    }
  }
