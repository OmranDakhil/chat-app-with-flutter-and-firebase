import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

part 'pop_up_menu_event.dart';
part 'pop_up_menu_state.dart';

class PopUpMenuBloc extends Bloc<PopUpMenuEvent, PopUpMenuState> {
  PopUpMenuBloc() : super(PopUpMenuInitial()) {
    on<PopUpMenuEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
