import 'package:advanced/data/data_source/remote_data_source.dart';
import 'package:advanced/data/mapper/mapper.dart';
import 'package:advanced/data/network/error_handler.dart';
import 'package:advanced/data/network/failure.dart';
import 'package:advanced/data/network/network_info.dart';
import 'package:advanced/data/network/requests.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:advanced/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import '../data_source/local_data_source.dart';

class RepositoryImpl implements Repository {

  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._remoteDataSource, this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          print('response.errorStatus is : ');
          print(response.status);
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print('an error occured : ' + 'aaaaaaaaaaaaaaaaaa');
        print(error);
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          print('response.errorStatus is : ');
          print(response.status);
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{
    try{
      final response = await _localDataSource.getHomeData();
      return right(response.toDomain());
    }catch(cacheError){
      /// cache is empty or not valid so it is time to get from api side
      if(await _networkInfo.isConnected){
        try{
          final response = await _remoteDataSource.getHomeData();
          if(response.status == ApiInternalStatus.SUCCESS){
            /// save response to cache
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          }else{
            return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }
      }else{
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.forgotPassword(email);
        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


}