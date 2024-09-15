import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/category.dart';
import '../../utility/utility.dart';

part 'category.freezed.dart';

part 'category.g.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(<CategoryModel>[]) List<CategoryModel> categoryList,
    @Default('') String selectedCategory1,
    @Default('') String selectedCategory2,
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

          list.add(val);
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
}
