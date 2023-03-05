
import 'package:advanced/data/data_source/remote_data_source.dart';
import 'package:advanced/data/network/app_api.dart';
import 'package:advanced/data/network/dio_factory.dart';
import 'package:advanced/data/network/network_info.dart';
import 'package:advanced/data/repository/repository_impl.dart';
import 'package:advanced/domain/repository/repository.dart';
import 'package:advanced/domain/usecase/login_usecase.dart';
import 'package:advanced/presentation/login/view_model/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

   /// repository
   instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<RemoteDataSource>(),instance<NetworkInfo>()));
 }

   initLoginModule() {
     if(!GetIt.I.isRegistered<LoginUseCase>()){
     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance<Repository>()));
     instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance<LoginUseCase>()));
     }
 }