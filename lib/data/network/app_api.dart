import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../../app/constants.dart';
import '../response/responses.dart';
part 'app_api.g.dart';



@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient{

  factory AppServiceClient(Dio dio , {String baseUrl}) = _AppServiceClient;
  @POST('/customers/login')
  Future<AuthenticationResponse> login(
      @Field('email') String email,
      @Field('password') String password,
      );

  @POST('/customers/register')
  Future<AuthenticationResponse> register(
      @Field('email') String email,
      @Field('password') String password,
      @Field('user_name') String name,
      @Field('profile_picture') String profilePicture,
      @Field('country_mobile_code') String countryCode,
      @Field('mobile_number') String mobileNumber,
      );

  @POST('/customers/forgotPassword')
  Future<ForgotPasswordResponse> forgotPassword(
      @Field('email') String email,
      );


  @GET('/home')
  Future<HomeResponse> getHomeData();
}
