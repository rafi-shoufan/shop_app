import 'package:advanced/data/data_source/remote_data_source.dart';
import 'package:advanced/data/mapper/mapper.dart';
import 'package:advanced/data/network/error_handler.dart';
import 'package:advanced/data/network/failure.dart';
import 'package:advanced/data/network/network_info.dart';
import 'package:advanced/data/network/requests.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:advanced/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository{

  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  RepositoryImpl(this._remoteDataSource,this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{

    if(await _networkInfo.isConnected){

      try{
        final response = await _remoteDataSource.login(loginRequest);

        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}