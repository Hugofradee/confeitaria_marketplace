import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../main.dart';
import '../../../models/confeitaria.dart';

part 'map_event.dart';
part 'map_state.dart';
part 'map_bloc.freezed.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<_Started>(_onStarted, transformer: droppable());
  }

  Future<void> _onStarted(_Started event, Emitter<MapState> emit) async {
    emit(state.copyWith(confeitarias: objectbox.confeitariaBox.getAll()));

    final query = objectbox.confeitariaBox.query().watch();

    await for (final confeitarias in query) {
      emit(state.copyWith(confeitarias: confeitarias.find()));
    }
  }
}
