
 import 'package:advanced/data/network/failure.dart';
import 'package:dio/dio.dart';

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
 }

 class ResponseMessage{
  static const String SUCCESS = 'success';
  static const String NO_CONTENT = 'success';
  static const String BAD_REQUEST = 'bad request, try again later';
  static const String UNAUTHORIZED = 'user is unauthorized, try again later';
  static const String FORBIDDEN = 'forbidden request, try again later';
  static const String INTERNAL_SERVER_ERROR = 'something went wrong, try again later';
  static const String NOT_FOUND = 'not found';


  static const String CONNECTION_TIMEDOUT = 'time out error, try again later';
  static const String CANCEL = 'request was canceled, try again later';
  static const String RECIEVE_TIMEOUT = 'time out error, try again later';
  static const String SEND_TIMEOUT = 'time out error, try again later';
  static const String CACHE_ERROR = 'cache error, try again later';
  static const String NO_INTERNET_CONNECTION = 'please check your internet connection';
  static const String DEFAULT = 'something went wrong, try again later';
 }


 extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECTION_TIMEDOUT:
        return Failure(ResponseCode.CONNECTION_TIMEDOUT, ResponseMessage.CONNECTION_TIMEDOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
 }


 class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      failure = _handleError(error);
    }else{
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {

    switch(error.type){

      case DioErrorType.connectionTimeout:
        return DataSource.CONNECTION_TIMEDOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();
      // case DioErrorType.badCertificate:
      //   return DataSource.RECIEVE_TIMEOUT.getFailure();
      case DioErrorType.badResponse:
        if(error.response != null && error.response?.statusMessage !=null && error.response?.statusCode!=null ){
          return Failure(error.response?.statusCode??0, error.response?.statusMessage??'error');
        }else{
          return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.connectionError:
        return DataSource.NO_INTERNET_CONNECTION.getFailure();

      case DioErrorType.unknown:
        return DataSource.DEFAULT.getFailure();

      default : return DataSource.NO_INTERNET_CONNECTION.getFailure();

    }

    }
 }

 class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
 }