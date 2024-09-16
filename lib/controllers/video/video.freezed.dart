// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoState {
  List<VideoModel> get videoList => throw _privateConstructorUsedError;
  Map<String, List<VideoModel>> get videoListMap =>
      throw _privateConstructorUsedError;

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoStateCopyWith<VideoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStateCopyWith<$Res> {
  factory $VideoStateCopyWith(
          VideoState value, $Res Function(VideoState) then) =
      _$VideoStateCopyWithImpl<$Res, VideoState>;
  @useResult
  $Res call(
      {List<VideoModel> videoList, Map<String, List<VideoModel>> videoListMap});
}

/// @nodoc
class _$VideoStateCopyWithImpl<$Res, $Val extends VideoState>
    implements $VideoStateCopyWith<$Res> {
  _$VideoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoList = null,
    Object? videoListMap = null,
  }) {
    return _then(_value.copyWith(
      videoList: null == videoList
          ? _value.videoList
          : videoList // ignore: cast_nullable_to_non_nullable
              as List<VideoModel>,
      videoListMap: null == videoListMap
          ? _value.videoListMap
          : videoListMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<VideoModel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoStateImplCopyWith<$Res>
    implements $VideoStateCopyWith<$Res> {
  factory _$$VideoStateImplCopyWith(
          _$VideoStateImpl value, $Res Function(_$VideoStateImpl) then) =
      __$$VideoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<VideoModel> videoList, Map<String, List<VideoModel>> videoListMap});
}

/// @nodoc
class __$$VideoStateImplCopyWithImpl<$Res>
    extends _$VideoStateCopyWithImpl<$Res, _$VideoStateImpl>
    implements _$$VideoStateImplCopyWith<$Res> {
  __$$VideoStateImplCopyWithImpl(
      _$VideoStateImpl _value, $Res Function(_$VideoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoList = null,
    Object? videoListMap = null,
  }) {
    return _then(_$VideoStateImpl(
      videoList: null == videoList
          ? _value._videoList
          : videoList // ignore: cast_nullable_to_non_nullable
              as List<VideoModel>,
      videoListMap: null == videoListMap
          ? _value._videoListMap
          : videoListMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<VideoModel>>,
    ));
  }
}

/// @nodoc

class _$VideoStateImpl implements _VideoState {
  const _$VideoStateImpl(
      {final List<VideoModel> videoList = const <VideoModel>[],
      final Map<String, List<VideoModel>> videoListMap = const {}})
      : _videoList = videoList,
        _videoListMap = videoListMap;

  final List<VideoModel> _videoList;
  @override
  @JsonKey()
  List<VideoModel> get videoList {
    if (_videoList is EqualUnmodifiableListView) return _videoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videoList);
  }

  final Map<String, List<VideoModel>> _videoListMap;
  @override
  @JsonKey()
  Map<String, List<VideoModel>> get videoListMap {
    if (_videoListMap is EqualUnmodifiableMapView) return _videoListMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_videoListMap);
  }

  @override
  String toString() {
    return 'VideoState(videoList: $videoList, videoListMap: $videoListMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStateImpl &&
            const DeepCollectionEquality()
                .equals(other._videoList, _videoList) &&
            const DeepCollectionEquality()
                .equals(other._videoListMap, _videoListMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_videoList),
      const DeepCollectionEquality().hash(_videoListMap));

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStateImplCopyWith<_$VideoStateImpl> get copyWith =>
      __$$VideoStateImplCopyWithImpl<_$VideoStateImpl>(this, _$identity);
}

abstract class _VideoState implements VideoState {
  const factory _VideoState(
      {final List<VideoModel> videoList,
      final Map<String, List<VideoModel>> videoListMap}) = _$VideoStateImpl;

  @override
  List<VideoModel> get videoList;
  @override
  Map<String, List<VideoModel>> get videoListMap;

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStateImplCopyWith<_$VideoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
