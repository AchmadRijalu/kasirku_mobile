import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasirku_mobile/models/login_form_model.dart';
import 'package:kasirku_mobile/models/user_model.dart';
import 'package:kasirku_mobile/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthRepository()
              .loginRepository(event.email, event.password);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());
          final LoginFormModel? loginFormModel =
              await AuthRepository().getCredentialFromLocal();
          final UserDataModel user = await AuthRepository()
              .loginRepository(loginFormModel?.email, loginFormModel?.password);

          emit(AuthSuccess(user));
        } catch (e) {
          print(e);
          emit(AuthFailure(e.toString()));
        }
      }
      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthRepository().logoutRepository();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }
    });
  }
}
