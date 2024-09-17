// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryState {
  List<CategoryModel> get categoryList => throw _privateConstructorUsedError;
  String get selectedCategory1 => throw _privateConstructorUsedError;
  String get selectedCategory2 => throw _privateConstructorUsedError;
  List<CategoryModel> get additionalCategoryList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryStateCopyWith<CategoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryStateCopyWith<$Res> {
  factory $CategoryStateCopyWith(
          CategoryState value, $Res Function(CategoryState) then) =
      _$CategoryStateCopyWithImpl<$Res, CategoryState>;
  @useResult
  $Res call(
      {List<CategoryModel> categoryList,
      String selectedCategory1,
      String selectedCategory2,
      List<CategoryModel> additionalCategoryList});
}

/// @nodoc
class _$CategoryStateCopyWithImpl<$Res, $Val extends CategoryState>
    implements $CategoryStateCopyWith<$Res> {
  _$CategoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryList = null,
    Object? selectedCategory1 = null,
    Object? selectedCategory2 = null,
    Object? additionalCategoryList = null,
  }) {
    return _then(_value.copyWith(
      categoryList: null == categoryList
          ? _value.categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      selectedCategory1: null == selectedCategory1
          ? _value.selectedCategory1
          : selectedCategory1 // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCategory2: null == selectedCategory2
          ? _value.selectedCategory2
          : selectedCategory2 // ignore: cast_nullable_to_non_nullable
              as String,
      additionalCategoryList: null == additionalCategoryList
          ? _value.additionalCategoryList
          : additionalCategoryList // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryStateImplCopyWith<$Res>
    implements $CategoryStateCopyWith<$Res> {
  factory _$$CategoryStateImplCopyWith(
          _$CategoryStateImpl value, $Res Function(_$CategoryStateImpl) then) =
      __$$CategoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CategoryModel> categoryList,
      String selectedCategory1,
      String selectedCategory2,
      List<CategoryModel> additionalCategoryList});
}

/// @nodoc
class __$$CategoryStateImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryStateImpl>
    implements _$$CategoryStateImplCopyWith<$Res> {
  __$$CategoryStateImplCopyWithImpl(
      _$CategoryStateImpl _value, $Res Function(_$CategoryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryList = null,
    Object? selectedCategory1 = null,
    Object? selectedCategory2 = null,
    Object? additionalCategoryList = null,
  }) {
    return _then(_$CategoryStateImpl(
      categoryList: null == categoryList
          ? _value._categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      selectedCategory1: null == selectedCategory1
          ? _value.selectedCategory1
          : selectedCategory1 // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCategory2: null == selectedCategory2
          ? _value.selectedCategory2
          : selectedCategory2 // ignore: cast_nullable_to_non_nullable
              as String,
      additionalCategoryList: null == additionalCategoryList
          ? _value._additionalCategoryList
          : additionalCategoryList // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
    ));
  }
}

/// @nodoc

class _$CategoryStateImpl implements _CategoryState {
  const _$CategoryStateImpl(
      {final List<CategoryModel> categoryList = const <CategoryModel>[],
      this.selectedCategory1 = '',
      this.selectedCategory2 = '',
      final List<CategoryModel> additionalCategoryList =
          const <CategoryModel>[]})
      : _categoryList = categoryList,
        _additionalCategoryList = additionalCategoryList;

  final List<CategoryModel> _categoryList;
  @override
  @JsonKey()
  List<CategoryModel> get categoryList {
    if (_categoryList is EqualUnmodifiableListView) return _categoryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryList);
  }

  @override
  @JsonKey()
  final String selectedCategory1;
  @override
  @JsonKey()
  final String selectedCategory2;
  final List<CategoryModel> _additionalCategoryList;
  @override
  @JsonKey()
  List<CategoryModel> get additionalCategoryList {
    if (_additionalCategoryList is EqualUnmodifiableListView)
      return _additionalCategoryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalCategoryList);
  }

  @override
  String toString() {
    return 'CategoryState(categoryList: $categoryList, selectedCategory1: $selectedCategory1, selectedCategory2: $selectedCategory2, additionalCategoryList: $additionalCategoryList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryStateImpl &&
            const DeepCollectionEquality()
                .equals(other._categoryList, _categoryList) &&
            (identical(other.selectedCategory1, selectedCategory1) ||
                other.selectedCategory1 == selectedCategory1) &&
            (identical(other.selectedCategory2, selectedCategory2) ||
                other.selectedCategory2 == selectedCategory2) &&
            const DeepCollectionEquality().equals(
                other._additionalCategoryList, _additionalCategoryList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categoryList),
      selectedCategory1,
      selectedCategory2,
      const DeepCollectionEquality().hash(_additionalCategoryList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryStateImplCopyWith<_$CategoryStateImpl> get copyWith =>
      __$$CategoryStateImplCopyWithImpl<_$CategoryStateImpl>(this, _$identity);
}

abstract class _CategoryState implements CategoryState {
  const factory _CategoryState(
      {final List<CategoryModel> categoryList,
      final String selectedCategory1,
      final String selectedCategory2,
      final List<CategoryModel> additionalCategoryList}) = _$CategoryStateImpl;

  @override
  List<CategoryModel> get categoryList;
  @override
  String get selectedCategory1;
  @override
  String get selectedCategory2;
  @override
  List<CategoryModel> get additionalCategoryList;
  @override
  @JsonKey(ignore: true)
  _$$CategoryStateImplCopyWith<_$CategoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
