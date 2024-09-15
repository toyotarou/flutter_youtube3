import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bunrui.freezed.dart';

part 'bunrui.g.dart';

@freezed
class BunruiState with _$BunruiState {
  const factory BunruiState({
    @Default(<List<String>>[]) List<List<String>> bunruiList,
  }) = _BunruiState;
}

@Riverpod(keepAlive: true)
class Bunrui extends _$Bunrui {
  ///
  @override
  BunruiState build() {
    // ignore: always_specify_types
    final List<String> listChild = List.generate(3, (int index) => '');

    final List<List<String>> listParent =
        // ignore: always_specify_types
        List.generate(10, (int index) => listChild);

    return BunruiState(bunruiList: listParent);
  }

  ///
  void setBunruiList({required int parentNumber, required String text}) {
    final List<List<String>> parentList = <List<String>>[...state.bunruiList];
    final List<String> childList = <String>[...parentList[parentNumber]];

    childList.add(text);

    parentList[parentNumber] = childList;

    state = state.copyWith(bunruiList: parentList);
  }

  ///
  void clearBunruiList() {
    // ignore: always_specify_types
    final List<String> listChild = List.generate(3, (int index) => '');

    final List<List<String>> listParent =
        // ignore: always_specify_types
        List.generate(10, (int index) => listChild);

    state = state.copyWith(bunruiList: listParent);
  }
}
