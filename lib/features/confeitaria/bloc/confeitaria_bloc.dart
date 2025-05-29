import 'package:bloc/bloc.dart';
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/objectbox_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confeitaria_event.dart';
part 'confeitaria_state.dart';
part 'confeitaria_bloc.freezed.dart';

class ConfeitariaBloc extends Bloc<ConfeitariaEvent, ConfeitariaState> {
  final ObjectBoxStore objectbox;
  ConfeitariaBloc(this.objectbox) : super(const ConfeitariaState()) {
    on<_Started>(_onStarted);
    on<_AddConfeitaria>(_onAddConfeitaria);
    on<_UpdateConfeitaria>(_onUpdateConfeitaria);
    on<_DeleteConfeitaria>(_onDeleteConfeitaria);
  }
  Future<void> _onStarted(_Started event, Emitter<ConfeitariaState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final confeitarias = objectbox.confeitariaBox.getAll();
      emit(state.copyWith(confeitarias: confeitarias, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onAddConfeitaria(_AddConfeitaria event, Emitter<ConfeitariaState> emit) async {
    objectbox.confeitariaBox.put(event.confeitaria);
    add(const ConfeitariaEvent.started());
  }

  Future<void> _onUpdateConfeitaria(_UpdateConfeitaria event, Emitter<ConfeitariaState> emit) async {
    objectbox.confeitariaBox.put(event.confeitaria);
    add(const ConfeitariaEvent.started());
  }

  Future<void> _onDeleteConfeitaria(_DeleteConfeitaria event, Emitter<ConfeitariaState> emit) async {
    objectbox.confeitariaBox.remove(event.id);
    add(const ConfeitariaEvent.started());
  }
}
