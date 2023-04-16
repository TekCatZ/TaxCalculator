import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tax_calculator/presentations/pages/routes_page/routes_page.dart';
import 'package:tax_calculator/repositories/local_auth_repository.dart';
import 'package:tax_calculator/utils/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init Bloc, service
  initializeServiceLocator();
  await GetIt.instance.get<LocalAuthRepository>().checkIfEnableLocalAuth();

  // Root Page
  runApp(const RoutesPage());
}
