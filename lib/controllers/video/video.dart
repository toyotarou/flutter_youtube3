import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
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
      final List<VideoModel> list = <VideoModel>[];

      final Map<String, List<VideoModel>> map = <String, List<VideoModel>>{};

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          map[val.bunrui] = <VideoModel>[];
        }

        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          // ignore: avoid_dynamic_calls
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          list.add(val);

          map[val.bunrui]?.add(val);
        }
      }

      state = state.copyWith(videoList: list, videoListMap: map);

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

    if (parentMap[bunrui] != null) {
      final List<VideoModel> childList = <VideoModel>[...parentMap[bunrui]!];

      childList.add(videoModel);

      parentMap[bunrui] = childList;

      state = state.copyWith(videoListMap: parentMap);
    }
  }
}
