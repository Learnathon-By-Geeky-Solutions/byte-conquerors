import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthServiceRepository authService;

  SignInBloc({required this.authService}) : super(SignInInitial()) {
    on<SignInButtonPressed>(_onSignIn);
  }

  void _onSignIn(SignInButtonPressed event, Emitter<SignInState> emit) async {
    emit(SignInLoading());

    try {
      final message = await authService.login(
        email: event.email,
        password: event.password,
      );

      if (message != null && message.contains('Success')) {
        emit(SignInSuccess());
      } else {
        emit(SignInFailure(message: message ?? "Login failed"));
      }
    } catch (e) {
      emit(SignInFailure(message: e.toString()));
    }
  }
}
