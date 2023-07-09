import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurants_app/app/app_prefs.dart';
import 'package:restaurants_app/data/data_source/local_data_source.dart';
import 'package:restaurants_app/data/data_source/remote_data_source.dart';
import 'package:restaurants_app/data/network/app_api.dart';
import 'package:restaurants_app/data/network/dio_factory.dart';
import 'package:restaurants_app/data/network/network_info.dart';
import 'package:restaurants_app/data/repository_impl/repository_impl.dart';
import 'package:restaurants_app/domain/repository/repository.dart';
import 'package:restaurants_app/domain/usecase/forgot_password_usecase.dart';
import 'package:restaurants_app/domain/usecase/home_usecase.dart';
import 'package:restaurants_app/domain/usecase/login_usecase.dart';
import 'package:restaurants_app/domain/usecase/register_usecase.dart';
import 'package:restaurants_app/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:restaurants_app/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:restaurants_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:restaurants_app/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../domain/usecase/store_details_usecase.dart';
import '../presentation/store_details/view_model/store_details_viewmodel.dart';

final instance = GetIt.instance;

// Singleton
Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  //local data source instance
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

// Factory
initLoginModule() {
  // if instance available don't give me another instance
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initRigesterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}