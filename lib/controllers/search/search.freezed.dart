// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState {
  String get searchWord => throw _privateConstructorUsedError;
  List<String> get youtubeIdList => throw _privateConstructorUsedError;
  List<String> get searchResultAlertDropdownValue =>
      throw _privateConstructorUsedError;
  String get searchTarget => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {String searchWord,
      List<String> youtubeIdList,
      List<String> searchResultAlertDropdownValue,
      String searchTarget});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchWord = null,
    Object? youtubeIdList = null,
    Object? searchResultAlertDropdownValue = null,
    Object? searchTarget = null,
  }) {
    return _then(_value.copyWith(
      searchWord: null == searchWord
          ? _value.searchWord
          : searchWord // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeIdList: null == youtubeIdList
          ? _value.youtubeIdList
          : youtubeIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchResultAlertDropdownValue: null == searchResultAlertDropdownValue
          ? _value.searchResultAlertDropdownValue
          : searchResultAlertDropdownValue // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchTarget: null == searchTarget
          ? _value.searchTarget
          : searchTarget // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
          _$SearchStateImpl value, $Res Function(_$SearchStateImpl) then) =
      __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String searchWord,
      List<String> youtubeIdList,
      List<String> searchResultAlertDropdownValue,
      String searchTarget});
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
      _$SearchStateImpl _value, $Res Function(_$SearchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchWord = null,
    Object? youtubeIdList = null,
    Object? searchResultAlertDropdownValue = null,
    Object? searchTarget = null,
  }) {
    return _then(_$SearchStateImpl(
      searchWord: null == searchWord
          ? _value.searchWord
          : searchWord // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeIdList: null == youtubeIdList
          ? _value._youtubeIdList
          : youtubeIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchResultAlertDropdownValue: null == searchResultAlertDropdownValue
          ? _value._searchResultAlertDropdownValue
          : searchResultAlertDropdownValue // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchTarget: null == searchTarget
          ? _value.searchTarget
          : searchTarget // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchStateImpl implements _SearchState {
  const _$SearchStateImpl(
      {this.searchWord = '',
      final List<String> youtubeIdList = const <String>[],
      final List<String> searchResultAlertDropdownValue = const <String>[],
      this.searchTarget = 'title'})
      : _youtubeIdList = youtubeIdList,
        _searchResultAlertDropdownValue = searchResultAlertDropdownValue;

  @override
  @JsonKey()
  final String searchWord;
  final List<String> _youtubeIdList;
  @override
  @JsonKey()
  List<String> get youtubeIdList {
    if (_youtubeIdList is EqualUnmodifiableListView) return _youtubeIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_youtubeIdList);
  }

  final List<String> _searchResultAlertDropdownValue;
  @override
  @JsonKey()
  List<String> get searchResultAlertDropdownValue {
    if (_searchResultAlertDropdownValue is EqualUnmodifiableListView)
      return _searchResultAlertDropdownValue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResultAlertDropdownValue);
  }

  @override
  @JsonKey()
  final String searchTarget;

  @override
  String toString() {
    return 'SearchState(searchWord: $searchWord, youtubeIdList: $youtubeIdList, searchResultAlertDropdownValue: $searchResultAlertDropdownValue, searchTarget: $searchTarget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.searchWord, searchWord) ||
                other.searchWord == searchWord) &&
            const DeepCollectionEquality()
                .equals(other._youtubeIdList, _youtubeIdList) &&
            const DeepCollectionEquality().equals(
                other._searchResultAlertDropdownValue,
                _searchResultAlertDropdownValue) &&
            (identical(other.searchTarget, searchTarget) ||
                other.searchTarget == searchTarget));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchWord,
      const DeepCollectionEquality().hash(_youtubeIdList),
      const DeepCollectionEquality().hash(_searchResultAlertDropdownValue),
      searchTarget);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState implements SearchState {
  const factory _SearchState(
      {final String searchWord,
      final List<String> youtubeIdList,
      final List<String> searchResultAlertDropdownValue,
      final String searchTarget}) = _$SearchStateImpl;

  @override
  String get searchWord;
  @override
  List<String> get youtubeIdList;
  @override
  List<String> get searchResultAlertDropdownValue;
  @override
  String get searchTarget;
  @override
  @JsonKey(ignore: true)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
