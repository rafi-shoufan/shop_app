import 'package:advanced/data/network/requests.dart';
import 'package:advanced/data/response/responses.dart';
import 'package:advanced/domain/models/models.dart';

import '../network/app_api.dart';

abstract class RemoteDataSource {

   Future<AuthenticationResponse> login(LoginRequest loginRequest);

   Future<AuthenticationResponse> register(RegisterRequest registerRequest);

   Future<ForgotPasswordResponse> forgotPassword(String email);

   Future<HomeResponse> getHomeData();

}

class RemoteDataSourceImpl implements RemoteDataSource{

   final AppServiceClient _appServiceClient;
   RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(
        loginRequest.email,
        loginRequest.password
    );
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async{
    return await _appServiceClient.register(
      registerRequest.email,
      registerRequest.password,
    registerRequest.name,
    'registerRequest.profilePicture',
    registerRequest.countryCode,
    registerRequest.mobileNumber,
    );

  }

  @override
  Future<HomeResponse> getHomeData() async{
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async{
    return await _appServiceClient.forgotPassword(email);
  }



}

