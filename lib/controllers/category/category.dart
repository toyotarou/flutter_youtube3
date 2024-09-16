import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/category_model.dart';
import '../../utility/utility.dart';

part 'category.freezed.dart';

part 'category.g.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(<CategoryModel>[]) List<CategoryModel> categoryList,
    @Default('') String selectedCategory1,
    @Default('') String selectedCategory2,
    @Default(<CategoryModel>[]) List<CategoryModel> additionalCategoryList,
  }) = _CategoryState;
}

@Riverpod(keepAlive: true)
class Category extends _$Category {
  ///
  @override
  CategoryState build() {
    return const CategoryState();
  }

  ///
  Future<void> getCategory() async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    // ignore: always_specify_types
    await client.post(path: APIPath.getYoutubeCategoryTree).then((value) {
      final List<CategoryModel> list = <CategoryModel>[];

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          // ignore: avoid_dynamic_calls
          final CategoryModel val =
              // ignore: avoid_dynamic_calls
              CategoryModel.fromJson(value['data'][i] as Map<String, dynamic>);

          if (val.bunrui != '') {
            list.add(val);
          }
        }
      }

      state = state.copyWith(categoryList: list);

      // ignore: always_specify_types
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  void setSelectedCategory1({required String category1}) =>
      state = state.copyWith(selectedCategory1: category1);

  ///
  void setSelectedCategory2({required String category2}) =>
      state = state.copyWith(selectedCategory2: category2);

  ///
  void setAdditionalCategoryList(
      {required String category1,
      required String category2,
      required String bunrui}) {
    final List<CategoryModel> list = <CategoryModel>[
      ...state.additionalCategoryList
    ];
    list.add(CategoryModel(
        category1: category1, category2: category2, bunrui: bunrui));
    state = state.copyWith(additionalCategoryList: list);
  }

  ///
  void clearAdditionalCategoryList() =>
      state = state.copyWith(additionalCategoryList: <CategoryModel>[]);
}
