import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_start_event.dart';
part 'app_start_state.dart';

class AppStartBloc extends Bloc<AppStartEvent, AppStartState> {
  AppStartBloc() : super(AppStartLoading()) {
    on<CheckAppStart>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final onboardingDone = prefs.getBool('onboarding_completed') ?? false;
      final user = FirebaseAuth.instance.currentUser;

      if (!onboardingDone) {
        emit(AppStartShowOnboarding());
      } else if (user != null) {
        emit(AppStartShowHome());
      } else {
        emit(AppStartShowLogin());
      }
    });
  }
}
