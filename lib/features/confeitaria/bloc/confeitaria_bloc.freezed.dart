// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confeitaria_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfeitariaEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConfeitariaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfeitariaEvent()';
  }
}

/// @nodoc
class $ConfeitariaEventCopyWith<$Res> {
  $ConfeitariaEventCopyWith(
      ConfeitariaEvent _, $Res Function(ConfeitariaEvent) __);
}

/// @nodoc

class _Started implements ConfeitariaEvent {
  const _Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfeitariaEvent.started()';
  }
}

/// @nodoc

class _AddConfeitaria implements ConfeitariaEvent {
  const _AddConfeitaria(this.confeitaria);

  final Confeitaria confeitaria;

  /// Create a copy of ConfeitariaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddConfeitariaCopyWith<_AddConfeitaria> get copyWith =>
      __$AddConfeitariaCopyWithImpl<_AddConfeitaria>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddConfeitaria &&
            (identical(other.confeitaria, confeitaria) ||
                other.confeitaria == confeitaria));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confeitaria);

  @override
  String toString() {
    return 'ConfeitariaEvent.addConfeitaria(confeitaria: $confeitaria)';
  }
}

/// @nodoc
abstract mixin class _$AddConfeitariaCopyWith<$Res>
    implements $ConfeitariaEventCopyWith<$Res> {
  factory _$AddConfeitariaCopyWith(
          _AddConfeitaria value, $Res Function(_AddConfeitaria) _then) =
      __$AddConfeitariaCopyWithImpl;
  @useResult
  $Res call({Confeitaria confeitaria});
}

/// @nodoc
class __$AddConfeitariaCopyWithImpl<$Res>
    implements _$AddConfeitariaCopyWith<$Res> {
  __$AddConfeitariaCopyWithImpl(this._self, this._then);

  final _AddConfeitaria _self;
  final $Res Function(_AddConfeitaria) _then;

  /// Create a copy of ConfeitariaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? confeitaria = null,
  }) {
    return _then(_AddConfeitaria(
      null == confeitaria
          ? _self.confeitaria
          : confeitaria // ignore: cast_nullable_to_non_nullable
              as Confeitaria,
    ));
  }
}

/// @nodoc

class _UpdateConfeitaria implements ConfeitariaEvent {
  const _UpdateConfeitaria(this.confeitaria);

  final Confeitaria confeitaria;

  /// Create a copy of ConfeitariaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateConfeitariaCopyWith<_UpdateConfeitaria> get copyWith =>
      __$UpdateConfeitariaCopyWithImpl<_UpdateConfeitaria>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateConfeitaria &&
            (identical(other.confeitaria, confeitaria) ||
                other.confeitaria == confeitaria));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confeitaria);

  @override
  String toString() {
    return 'ConfeitariaEvent.updateConfeitaria(confeitaria: $confeitaria)';
  }
}

/// @nodoc
abstract mixin class _$UpdateConfeitariaCopyWith<$Res>
    implements $ConfeitariaEventCopyWith<$Res> {
  factory _$UpdateConfeitariaCopyWith(
          _UpdateConfeitaria value, $Res Function(_UpdateConfeitaria) _then) =
      __$UpdateConfeitariaCopyWithImpl;
  @useResult
  $Res call({Confeitaria confeitaria});
}

/// @nodoc
class __$UpdateConfeitariaCopyWithImpl<$Res>
    implements _$UpdateConfeitariaCopyWith<$Res> {
  __$UpdateConfeitariaCopyWithImpl(this._self, this._then);

  final _UpdateConfeitaria _self;
  final $Res Function(_UpdateConfeitaria) _then;

  /// Create a copy of ConfeitariaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? confeitaria = null,
  }) {
    return _then(_UpdateConfeitaria(
      null == confeitaria
          ? _self.confeitaria
          : confeitaria // ignore: cast_nullable_to_non_nullable
              as Confeitaria,
    ));
  }
}

/// @nodoc

class _DeleteConfeitaria implements ConfeitariaEvent {
  const _DeleteConfeitaria(this.id);

  final int id;

  /// Create a copy of ConfeitariaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteConfeitariaCopyWith<_DeleteConfeitaria> get copyWith =>
      __$DeleteConfeitariaCopyWithImpl<_DeleteConfeitaria>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeleteConfeitaria &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'ConfeitariaEvent.deleteConfeitaria(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$DeleteConfeitariaCopyWith<$Res>
    implements $ConfeitariaEventCopyWith<$Res> {
  factory _$DeleteConfeitariaCopyWith(
          _DeleteConfeitaria value, $Res Function(_DeleteConfeitaria) _then) =
      __$DeleteConfeitariaCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$DeleteConfeitariaCopyWithImpl<$Res>
    implements _$DeleteConfeitariaCopyWith<$Res> {
  __$DeleteConfeitariaCopyWithImpl(this._self, this._then);

  final _DeleteConfeitaria _self;
  final $Res Function(_DeleteConfeitaria) _then;

  /// Create a copy of ConfeitariaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_DeleteConfeitaria(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ConfeitariaState {
  List<Confeitaria> get confeitarias;
  bool get isLoading;
  String? get errorMessage;

  /// Create a copy of ConfeitariaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfeitariaStateCopyWith<ConfeitariaState> get copyWith =>
      _$ConfeitariaStateCopyWithImpl<ConfeitariaState>(
          this as ConfeitariaState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfeitariaState &&
            const DeepCollectionEquality()
                .equals(other.confeitarias, confeitarias) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(confeitarias),
      isLoading,
      errorMessage);

  @override
  String toString() {
    return 'ConfeitariaState(confeitarias: $confeitarias, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ConfeitariaStateCopyWith<$Res> {
  factory $ConfeitariaStateCopyWith(
          ConfeitariaState value, $Res Function(ConfeitariaState) _then) =
      _$ConfeitariaStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Confeitaria> confeitarias, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$ConfeitariaStateCopyWithImpl<$Res>
    implements $ConfeitariaStateCopyWith<$Res> {
  _$ConfeitariaStateCopyWithImpl(this._self, this._then);

  final ConfeitariaState _self;
  final $Res Function(ConfeitariaState) _then;

  /// Create a copy of ConfeitariaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confeitarias = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      confeitarias: null == confeitarias
          ? _self.confeitarias
          : confeitarias // ignore: cast_nullable_to_non_nullable
              as List<Confeitaria>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _ConfeitariaState implements ConfeitariaState {
  const _ConfeitariaState(
      {final List<Confeitaria> confeitarias = const [],
      this.isLoading = false,
      this.errorMessage})
      : _confeitarias = confeitarias;

  final List<Confeitaria> _confeitarias;
  @override
  @JsonKey()
  List<Confeitaria> get confeitarias {
    if (_confeitarias is EqualUnmodifiableListView) return _confeitarias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_confeitarias);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  /// Create a copy of ConfeitariaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConfeitariaStateCopyWith<_ConfeitariaState> get copyWith =>
      __$ConfeitariaStateCopyWithImpl<_ConfeitariaState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConfeitariaState &&
            const DeepCollectionEquality()
                .equals(other._confeitarias, _confeitarias) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_confeitarias),
      isLoading,
      errorMessage);

  @override
  String toString() {
    return 'ConfeitariaState(confeitarias: $confeitarias, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ConfeitariaStateCopyWith<$Res>
    implements $ConfeitariaStateCopyWith<$Res> {
  factory _$ConfeitariaStateCopyWith(
          _ConfeitariaState value, $Res Function(_ConfeitariaState) _then) =
      __$ConfeitariaStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Confeitaria> confeitarias, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$ConfeitariaStateCopyWithImpl<$Res>
    implements _$ConfeitariaStateCopyWith<$Res> {
  __$ConfeitariaStateCopyWithImpl(this._self, this._then);

  final _ConfeitariaState _self;
  final $Res Function(_ConfeitariaState) _then;

  /// Create a copy of ConfeitariaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? confeitarias = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_ConfeitariaState(
      confeitarias: null == confeitarias
          ? _self._confeitarias
          : confeitarias // ignore: cast_nullable_to_non_nullable
              as List<Confeitaria>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
