import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tax_calculator/repositories/local_auth_repository.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final LocalAuthRepository _localAuthRepository;

  RoutesBloc(this._localAuthRepository)
      : super(_localAuthRepository.isEnableLocalAuth()
            ? RoutesUserUnAuthenicatedWithLocalAuth()
            : RoutesUserUnAuthenicated()) {
    on<LogOut>((event, emit) {
      logOutRequest(event, emit);
    });
    on<UserStatusChange>((event, emit) {
      userChange(event, emit);
    });
  }

  void logOutRequest(LogOut event, Emitter<RoutesState> emit) {
    if (_localAuthRepository.isEnableLocalAuth()) {
      emit(RoutesUserUnAuthenicatedWithLocalAuth());
    } else {
      emit(RoutesUserUnAuthenicated());
    }
  }

  void userChange(UserStatusChange event, Emitter<RoutesState> emit) {
    /*final user = _firebaseAuthenicationRepository.currentUser;
    if (user.isNotEmpty) {
      emit(RoutesUserAuthenicated());
    } else {
      if (_localAuthRepository.isEnableLocalAuth()) {
        emit(RoutesUserUnAuthenicatedWithLocalAuth());
      } else {
        emit(RoutesUserUnAuthenicated());
      }
    }*/
  }
}
