part of 'confeitaria_bloc.dart';

@freezed
class ConfeitariaEvent with _$ConfeitariaEvent {
  const factory ConfeitariaEvent.started() = _Started;
  const factory ConfeitariaEvent.addConfeitaria(Confeitaria confeitaria) = _AddConfeitaria;
  const factory ConfeitariaEvent.updateConfeitaria(Confeitaria confeitaria) = _UpdateConfeitaria;
  const factory ConfeitariaEvent.deleteConfeitaria(int id) = _DeleteConfeitaria;
}