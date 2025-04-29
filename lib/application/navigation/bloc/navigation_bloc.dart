import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<NavigateTo>(_onNavigateTo);
  }

  void _onNavigateTo(NavigateTo event, Emitter<NavigationState> emit) {
    if (event.index != state.selectedIndex) {
      emit(NavigationState(event.index));
    }
  }

  @override
  Future<void> close() {
    // You can optionally log or track when the bloc is closed
    debugPrint("NavigationBloc closed");
    return super.close();
  }
}
