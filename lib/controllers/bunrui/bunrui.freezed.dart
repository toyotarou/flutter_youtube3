// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bunrui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BunruiState {
  List<List<String>> get bunruiList => throw _privateConstructorUsedError;

  /// Create a copy of BunruiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BunruiStateCopyWith<BunruiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BunruiStateCopyWith<$Res> {
  factory $BunruiStateCopyWith(
          BunruiState value, $Res Function(BunruiState) then) =
      _$BunruiStateCopyWithImpl<$Res, BunruiState>;
  @useResult
  $Res call({List<List<String>> bunruiList});
}

/// @nodoc
class _$BunruiStateCopyWithImpl<$Res, $Val extends BunruiState>
    implements $BunruiStateCopyWith<$Res> {
  _$BunruiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BunruiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bunruiList = null,
  }) {
    return _then(_value.copyWith(
      bunruiList: null == bunruiList
          ? _value.bunruiList
          : bunruiList // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BunruiStateImplCopyWith<$Res>
    implements $BunruiStateCopyWith<$Res> {
  factory _$$BunruiStateImplCopyWith(
          _$BunruiStateImpl value, $Res Function(_$BunruiStateImpl) then) =
      __$$BunruiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<String>> bunruiList});
}

/// @nodoc
class __$$BunruiStateImplCopyWithImpl<$Res>
    extends _$BunruiStateCopyWithImpl<$Res, _$BunruiStateImpl>
    implements _$$BunruiStateImplCopyWith<$Res> {
  __$$BunruiStateImplCopyWithImpl(
      _$BunruiStateImpl _value, $Res Function(_$BunruiStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BunruiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bunruiList = null,
  }) {
    return _then(_$BunruiStateImpl(
      bunruiList: null == bunruiList
          ? _value._bunruiList
          : bunruiList // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ));
  }
}

/// @nodoc

class _$BunruiStateImpl implements _BunruiState {
  const _$BunruiStateImpl(
      {final List<List<String>> bunruiList = const <List<String>>[]})
      : _bunruiList = bunruiList;

  final List<List<String>> _bunruiList;
  @override
  @JsonKey()
  List<List<String>> get bunruiList {
    if (_bunruiList is EqualUnmodifiableListView) return _bunruiList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bunruiList);
  }

  @override
  String toString() {
    return 'BunruiState(bunruiList: $bunruiList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BunruiStateImpl &&
            const DeepCollectionEquality()
                .equals(other._bunruiList, _bunruiList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bunruiList));

  /// Create a copy of BunruiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BunruiStateImplCopyWith<_$BunruiStateImpl> get copyWith =>
      __$$BunruiStateImplCopyWithImpl<_$BunruiStateImpl>(this, _$identity);
}

abstract class _BunruiState implements BunruiState {
  const factory _BunruiState({final List<List<String>> bunruiList}) =
      _$BunruiStateImpl;

  @override
  List<List<String>> get bunruiList;

  /// Create a copy of BunruiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BunruiStateImplCopyWith<_$BunruiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
