import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthServiceRepository authRepository;

  SignUpBloc({required this.authRepository}) : super(SignUpInitial()) {
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());
      try {
        final response = await authRepository.registration(
          // name: event.name,
          email: event.email,
          password: event.password,
        );

        if (response != null && response.contains('Success')) {
          emit(SignUpSuccess());
        } else {
          emit(SignUpFailure(error: response ?? 'Unknown error'));
        }
      } catch (e) {
        emit(SignUpFailure(error: e.toString()));
      }
    });
  }
}
