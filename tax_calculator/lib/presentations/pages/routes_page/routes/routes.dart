import 'package:flutter/widgets.dart';
import 'package:tax_calculator/presentations/bloc/routes_page/routes_bloc.dart';
import 'package:tax_calculator/presentations/pages/login_page/login_page.dart';

// Route Page
// ThangNP3
List<Page> onGenerateAppViewPages(
  RoutesState state,
  List<Page> pages,
) {
  if (state is RoutesUserAuthenicated) {
    //return [NavigationBottomBar.page()];
  }

  if (state is RoutesUserUnAuthenicated) {
    //return [LoginPage.page()];
  }

  return [LoginPage.page()];

  //return [SimpleLoginPage.page()];
}
