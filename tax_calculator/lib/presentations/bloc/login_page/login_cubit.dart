import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

/// ロギングのBloC
/// ThangNP3
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  Future<void> loginWithUserAndPassword(String email, String password) async {
    try {
      emit(const LoginLoading());
      emit(LoginSubmit(email, password));
    } catch (exception) {
      emit(LoginError(exception.toString()));
    }
  }
}
