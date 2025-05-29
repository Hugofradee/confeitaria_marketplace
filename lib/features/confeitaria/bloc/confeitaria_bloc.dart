import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confeitaria_event.dart';
part 'confeitaria_state.dart';
part 'confeitaria_bloc.freezed.dart';

class ConfeitariaBloc extends Bloc<ConfeitariaEvent, ConfeitariaState> {
  ConfeitariaBloc() : super(_Initial()) {
    on<ConfeitariaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
