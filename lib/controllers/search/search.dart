import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';

part 'search.freezed.dart';

part 'search.g.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String searchWord,
    @Default(<String>[]) List<String> youtubeIdList,
    @Default(<String>[]) List<String> searchResultAlertDropdownValue,
    @Default('title') String searchTarget,
  }) = _SearchState;
}

@Riverpod(keepAlive: true)
class Search extends _$Search {
  ///
  @override
  SearchState build() {
    // ignore: always_specify_types
    final List<String> dropdownValue = List.generate(1000, (int index) => '');

    return SearchState(searchResultAlertDropdownValue: dropdownValue);
  }

  ///
  Future<void> getSearchYoutubeId({required String word}) async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    // ignore: always_specify_types
    await client.post(
      path: APIPath.searchYoutubeId,
      body: <String, String>{'word': word, 'target': state.searchTarget},
      // ignore: always_specify_types
    ).then((value) {
      final List<String> list = <String>[];

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          // ignore: avoid_dynamic_calls
          list.add(value['data'][i] as String);
        }
      }

      state = state.copyWith(searchWord: word, youtubeIdList: list);

      // ignore: always_specify_types
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  void setSearchResultAlertDropdownValue(
      {required int index, required String bunrui}) {
    final List<String> list = <String>[...state.searchResultAlertDropdownValue];
    list[index] = bunrui;
    state = state.copyWith(searchResultAlertDropdownValue: list);
  }

  ///
  void clearSearchResultAlertDropdownValue() {
    // ignore: always_specify_types
    final List<String> list = List.generate(1000, (int index) => '');

    state = state.copyWith(searchResultAlertDropdownValue: list);
  }

  ///
  void setSearchTarget({required String target}) =>
      state = state.copyWith(searchTarget: target);
}
