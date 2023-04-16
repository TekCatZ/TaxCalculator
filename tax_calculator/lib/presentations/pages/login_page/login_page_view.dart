import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tax_calculator/presentations/bloc/login_page/login_cubit.dart';
import 'package:tax_calculator/presentations/pages/common/LoadingIndicator/common_loading_indicator.dart';

// ロギング画面UI
// ThangNP3
class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageViewState();
  }
}

class _LoginPageViewState extends State<LoginPageView> {
  _LoginPageViewState();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is LoginSubmit) {
          /*Navigator.of(context).push<void>(AskBioMetricsPermissionPage.route(
              state.username, state.password));*/
        }
      },
      builder: (context, state) {
        if (state is LoginInitial) {
          return buildInitialInput();
        } else if (state is LoginLoading) {
          return buildLoading();
        } else {
          // state is unknow, errror
          return buildInitialInput();
        }
      },
    );
  }

  Widget buildLoading() {
    return const CommonLoadingIdicator();
  }

  Widget buildInitialInput() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: "Email")),
        const SizedBox(height: 20),
        TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: "Passwrod")),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                submitUserNameAndPassword(
                    context, emailController.text, passwordController.text);
              },
              child: const Text('LOGIN'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                //Navigator.of(context).push<void>(SignUpPage.route());
              },
              child: const Text('Sign Up'),
            )
          ],
        )
      ],
    );
  }

  void submitUserNameAndPassword(
      BuildContext context, String email, String password) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final loginCubit = context.read<LoginCubit>();
    loginCubit.loginWithUserAndPassword(email, password);
  }
}
