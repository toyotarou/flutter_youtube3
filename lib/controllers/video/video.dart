import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/category_model.dart';
import '../../models/special_video_model.dart';
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
    @Default(<SpecialVideoModel>[]) List<SpecialVideoModel> specialModelList,
    @Default(<String, List<VideoModel>>{})
    Map<String, List<VideoModel>> publishDateVideoMap,
    @Default(<String, List<VideoModel>>{})
    Map<String, List<VideoModel>> getDateVideoMap,
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
  void clearVideoList() => state = state.copyWith(videoList: <VideoModel>[]);

  ///
  Future<void> getYoutubeList() async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    // ignore: always_specify_types
    await client.post(path: APIPath.getYoutubeList).then((value) {
      final Map<String, List<VideoModel>> map = <String, List<VideoModel>>{};

      final Map<String, VideoModel> map2 = <String, VideoModel>{};

      final Map<String, List<VideoModel>> map3 = <String, List<VideoModel>>{};
      final Map<String, List<VideoModel>> map4 = <String, List<VideoModel>>{};

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          map[val.bunrui] = <VideoModel>[];

          map2[val.youtubeId] = val;

          if (val.pubdate != null) {
            map3[val.pubdate!.yyyymmdd] = <VideoModel>[];
          }

          map4['${val.getdate.substring(0, 4)}-${val.getdate.substring(4, 6)}-${val.getdate.substring(6)}'] =
              <VideoModel>[];
        }

        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          // ignore: avoid_dynamic_calls
          final VideoModel val =
              // ignore: avoid_dynamic_calls
              VideoModel.fromJson(value['data'][i] as Map<String, dynamic>);

          map[val.bunrui]?.add(val);

          if (val.pubdate != null) {
            map3[val.pubdate!.yyyymmdd]?.add(val);
          }

          map4['${val.getdate.substring(0, 4)}-${val.getdate.substring(4, 6)}-${val.getdate.substring(6)}']
              ?.add(val);
        }
      }

      state = state.copyWith(
        videoListMap: map,
        videoModelMap: map2,
        publishDateVideoMap: map3,
        getDateVideoMap: map4,
      );

      // ignore: always_specify_types
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> getSpecialVideo() async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    // ignore: always_specify_types
    await client.post(path: APIPath.getSpecialVideo).then((value) {
      final List<SpecialVideoModel> list = <SpecialVideoModel>[];

      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        for (int i = 0; i < value['data'].length.toString().toInt(); i++) {
          list.add(SpecialVideoModel.fromJson(
              // ignore: avoid_dynamic_calls
              value['data'][i] as Map<String, dynamic>));
        }
      }

      state = state.copyWith(specialModelList: list);

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

  ///
  void clearSelectedYoutubeIdList() =>
      state = state.copyWith(selectedYoutubeIdList: <String>[]);

  ///
  Future<void> updateVideoPlayedAt({required String youtubeId}) async {
    final Utility utility = Utility();

    final HttpClient client = ref.read(httpClientProvider);

    final Map<String, dynamic> uploadData = <String, dynamic>{};
    uploadData['date'] = DateTime.now().yyyymmdd;
    uploadData['youtube_id'] = youtubeId;

    await client
        .post(path: APIPath.updateVideoPlayedAt, body: uploadData)
        // ignore: always_specify_types
        .catchError((error, _) => utility.showError('予期せぬエラーが発生しました'));
  }
}
