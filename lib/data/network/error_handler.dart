
 import 'package:advanced/data/network/failure.dart';
import 'package:advanced/presentation/resources/strings_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

enum DataSource{
   SUCCESS,
   NO_CONTENT,
   BAD_REQUEST,
   FORBIDDEN,
   UNAUTHORIZED,
   NOT_FOUND,
   INTERNAL_SERVER_ERROR,
   CONNECTION_TIMEDOUT,
   CANCEL,
   RECIEVE_TIMEOUT,
   SEND_TIMEOUT,
   CACHE_ERROR,
   NO_INTERNET_CONNECTION,
   BAD_CERTIFICATE,
   DEFAULT,
 }

 class ResponseCode{

  static const int SUCCESS = 200;  /// success with data
  static const int NO_CONTENT = 201; /// success without data
  static const int BAD_REQUEST = 400; /// failure API rejected request
  static const int UNAUTHORIZED = 401; /// failure user is not authorized
  static const int FORBIDDEN = 403; /// failure API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; /// failure crash in server side
  static const int NOT_FOUND = 404; /// not found

  // local status code

  static const int CONNECTION_TIMEDOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
  static const int BAD_CERTIFICATE = -8;
 }

 class ResponseMessage{
  static const String SUCCESS = AppStrings.success;
  static const String NO_CONTENT = AppStrings.success;
  static const String BAD_REQUEST = AppStrings.badRequestError;
  static const String UNAUTHORIZED = AppStrings.unauthorizedError;
  static const String FORBIDDEN = AppStrings.forbiddenError;
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError;
  static const String NOT_FOUND = AppStrings.notFoundError;


  static const String CONNECTION_TIMEDOUT = AppStrings.timeOutError;
  static const String CANCEL = AppStrings.defaultError;
  static const String RECIEVE_TIMEOUT = AppStrings.timeOutError;
  static const String SEND_TIMEOUT = AppStrings.timeOutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
  static const String BAD_CERTIFICATE = AppStrings.badCertificate;
  static const String DEFAULT = AppStrings.defaultError;
 }


 extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS.tr());
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT.tr());
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr());
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr());
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED.tr());
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND.tr());
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR.tr());
      case DataSource.CONNECTION_TIMEDOUT:
        return Failure(ResponseCode.CONNECTION_TIMEDOUT, ResponseMessage.CONNECTION_TIMEDOUT.tr());
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL.tr());
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT.tr());
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr());
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr());
      case DataSource.NO_INTERNET_CONNECTION:
        print('get failure');
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION.tr());
      case DataSource.BAD_CERTIFICATE:
        print('get failure');
        return Failure(ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE.tr());
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT.tr());
    }
  }
 }


 class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      print("if(error is DioError)");
      failure = _handleError(error);
    }else{
      print("error is not dio error");
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {

    print("first handle error");
    switch(error.type){
      case DioErrorType.connectionTimeout:
        return DataSource.CONNECTION_TIMEDOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();
      case DioErrorType.badCertificate:
        return DataSource.BAD_CERTIFICATE.getFailure();
      case DioErrorType.badResponse:
        if(error.response != null && error.response?.statusMessage !=null && error.response?.statusCode!=null ){
          print('if badResponse');
          return Failure(error.response?.statusCode??0, error.response?.statusMessage??'error');
        }else{
          print('else badResponse');
          return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.connectionError:
        print('switch _handleError');
        return DataSource.NO_INTERNET_CONNECTION.getFailure();
      case DioErrorType.unknown:
        print('unknownnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        return DataSource.DEFAULT.getFailure();
      default : return DataSource.NO_INTERNET_CONNECTION.getFailure();
    }
    }
 }

 class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
 }