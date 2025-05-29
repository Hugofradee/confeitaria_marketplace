part of 'confeitaria_bloc.dart';

@freezed
abstract class ConfeitariaState with _$ConfeitariaState {
  const factory ConfeitariaState({
    @Default(false) bool isLoading,
    @Default([]) List<Confeitaria> confeitarias,
    String? errorMessage
  }) = _ConfeitariaState;

}
