part of 'app_start_bloc.dart';

abstract class AppStartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStartLoading extends AppStartState {}

class AppStartShowOnboarding extends AppStartState {}

class AppStartShowLogin extends AppStartState {}

class AppStartShowHome extends AppStartState {}
