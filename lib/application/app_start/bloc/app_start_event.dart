part of 'app_start_bloc.dart';

abstract class AppStartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAppStart extends AppStartEvent {}
