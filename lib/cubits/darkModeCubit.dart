import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Dark_lightModeState {}

class initialtModeState extends Dark_lightModeState {}

class DarkModeState extends Dark_lightModeState {}

class LightModeState extends Dark_lightModeState {}

class Dark_lightModeCubit extends Cubit<Dark_lightModeState> {
  Dark_lightModeCubit() : super(initialtModeState());
  String mode = '';
  void darkAndlightMode(String onpressMode) {
    if (onpressMode == 'light') {
      log('light from cubit');
      mode = 'light';
      emit(LightModeState());
    } else {
      log('dark from cubit');
      mode = 'dark';
      emit(DarkModeState());
    }
  }
}
