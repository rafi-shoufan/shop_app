
import 'package:advanced/data/data_source/remote_data_source.dart';
import 'package:advanced/data/network/app_api.dart';
import 'package:advanced/data/network/dio_factory.dart';
import 'package:advanced/data/network/network_info.dart';
import 'package:advanced/data/repository/repository_impl.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:advanced/domain/repository/repository.dart';
import 'package:advanced/domain/usecase/get_home_usecase.dart';
import 'package:advanced/domain/usecase/login_usecase.dart';
import 'package:advanced/domain/usecase/register_usecase.dart';
import 'package:advanced/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:advanced/presentation/login/view_model/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/local_data_source.dart';
import '../presentation/forgot_password/view_model/forgot_password_view_model.dart';
import '../presentation/main/pages/home/view_model/home_view_model.dart';
import '../presentation/register/view_model/register_view_model.dart';
import 'app_preferences.dart';

final instance = GetIt.instance;

 Future<void> initAppModule() async{
   /// we use factory to make a new object every time we call it
   //instance.registerFactory();  
   /// we use singleton to make one object and modify on the same object every time we call it (not make a new one)
   //instance.registerSingleton();
   /// we use lazy to make the object only when we call it and that is good for the performance and memory saver

   /// shared preference instance
   final sharedPreference = await SharedPreferences.getInstance();

   instance.registerLazySingleton<SharedPreferences>(() => sharedPreference);

   /// app preference instance
   instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>()));

   /// network info
   instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

   /// dio factory
   instance.registerLazySingleton<DioFactory>(() => DioFactory(instance<AppPreferences>()));

   /// app service client
   Dio dio = await instance<DioFactory>().getDio();
   instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

   /// remote data source
   instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));

   /// local data source
   instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

   /// repository
   instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<RemoteDataSource>(),instance<NetworkInfo>(),instance<LocalDataSource>()));
 }

   initLoginModule() {
     if(!GetIt.I.isRegistered<LoginUseCase>()){
     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance<Repository>()));
     instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance<LoginUseCase>()));
     }
 }

  // initForgotPasswordModule() {
  //   if(!GetIt.I.isRegistered<ForgotPasswordUseCase>()){
  //     instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance<Repository>()));
  //     instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance<ForgotPasswordUseCase>()));
  //   }
  // }

  initRegisterModule() {
    if(!GetIt.I.isRegistered<RegisterUseCase>()){
      instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance<Repository>()));
      instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance<RegisterUseCase>()));
      instance.registerFactory<ImagePicker>(() => ImagePicker());
    }
  }

  initHomeModule() {
    if(!GetIt.I.isRegistered<HomeUseCase>()){
      instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance<Repository>()));
      instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance<HomeUseCase>()));
    }
  }