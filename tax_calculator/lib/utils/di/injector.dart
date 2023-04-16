import 'package:get_it/get_it.dart';
import 'package:tax_calculator/data/local/shared_preferences_provider.dart';
import 'package:tax_calculator/repositories/local_auth_repository.dart';

import '../../presentations/bloc/login_page/login_cubit.dart';
import '../../presentations/bloc/routes_page/routes_bloc.dart';

// サービスロケータを初期化する
void initializeServiceLocator() {
  initDatabase();
  _initSingleton();
  _initializeServiceBloc();
}

void _initializeServiceBloc() {
  GetIt getIt = GetIt.instance;
  getIt.registerFactory<RoutesBloc>(
      () => RoutesBloc(getIt.get<LocalAuthRepository>()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit());
}

void _initSingleton() {
  GetIt getIt = GetIt.instance;

  GetIt.instance.registerSingleton<LocalAuthRepository>(LocalAuthRepository(
    getIt.get<SharedPreferencesProvider>(),
  ));
}

void initDatabase() {
  GetIt.instance.registerSingleton<SharedPreferencesProvider>(
      SharedPreferencesProvider());
}
