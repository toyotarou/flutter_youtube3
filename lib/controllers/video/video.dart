import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/category_model.dart';
import '../../models/video_model.dart';
import '../../utility/utility.dart';

part 'video.freezed.dart';

part 'video.g.dart';

@freezed
class VideoState with _$VideoState {
  const factory VideoState({
    @Default(<VideoModel>[]) List<VideoModel> videoList,
    @Default(<String, List<VideoModel>>{})
    Map<String, List<VideoModel>> videoListMap,
    @Default(<String, VideoModel>{}) Map<String, VideoModel> videoModelMap,
    @Default(<String, CategoryModel>{})
    Map<String, CategoryModel> bunruiBlankSettingMap,
    @Default(<String>[]) List<String> selectedYoutubeIdList,
  }) = _VideoState;
}

@Riverpod(keepAlive: true)
class Video extends _$Video {
  ///
  @override
  VideoState build() {
    return const VideoState();
  }

  ///
  Future<void> getBunruiBlankVideo() async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    // ignore: always_specify_types
    await client.post(path: APIPath.getBlankBunruiVideo).then((value) {
      final List<VideoModel> list = <VideoModel>[];

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          // ignore: avoid_dynamic_calls
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          list.add(val);
        }
      }

      state = state.copyWith(videoList: list);

      // ignore: always_specify_types
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> getYoutubeList() async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    // ignore: always_specify_types
    await client.post(path: APIPath.getYoutubeList).then((value) {
      final Map<String, List<VideoModel>> map = <String, List<VideoModel>>{};

      final Map<String, VideoModel> map2 = <String, VideoModel>{};

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          map[val.bunrui] = <VideoModel>[];

          map2[val.youtubeId] = val;
        }

        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          // ignore: avoid_dynamic_calls
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          map[val.bunrui]?.add(val);
        }
      }

      state = state.copyWith(videoListMap: map, videoModelMap: map2);

      // ignore: always_specify_types
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  void addVideoListMap(
      {required String bunrui, required VideoModel videoModel}) {
    final Map<String, List<VideoModel>> parentMap = <String, List<VideoModel>>{
      ...state.videoListMap
    };

    List<VideoModel> childList = <VideoModel>[];

    if (parentMap[bunrui] != null) {
      childList = <VideoModel>[...parentMap[bunrui]!];
    }

    childList.add(videoModel);

    parentMap[bunrui] = childList;

    state = state.copyWith(videoListMap: parentMap);
  }

  ///
  void setBunruiBlankSettingMap(
      {required String youtubeId,
      required String bunrui,
      required String category1,
      required String category2}) {
    final Map<String, CategoryModel> map = <String, CategoryModel>{
      ...state.bunruiBlankSettingMap
    };
    map[youtubeId] = CategoryModel(
        category1: category1, category2: category2, bunrui: bunrui);
    state = state.copyWith(bunruiBlankSettingMap: map);
  }

  ///
  void setSelectedYoutubeIdList({required String youtubeId}) {
    final List<String> list = <String>[...state.selectedYoutubeIdList];

    if (list.contains(youtubeId)) {
      list.remove(youtubeId);
    } else {
      list.add(youtubeId);
    }

    state = state.copyWith(selectedYoutubeIdList: list);
  }

  ///
  Future<void> manipulateVideoList({required String bunrui}) async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    final List<String> youtubeIdList = <String>[...state.selectedYoutubeIdList];

    final List<String> list = <String>[];
    for (final String element in youtubeIdList) {
      if (element != '') {
        list.add("'$element'");
      }
    }

    await client.post(path: APIPath.bunruiYoutubeData, body: <String, dynamic>{
      'bunrui': bunrui,
      'youtube_id': list.join(',')
      // ignore: always_specify_types
    }).catchError((error, _) => utility.showError('予期せぬエラーが発生しました'));
  }
}
