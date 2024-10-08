import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/category/category.dart';
import '../../controllers/search/search.dart';
import '../../controllers/video/video.dart';
import '../../extensions/extensions.dart';
import '../../models/category_model.dart';
import '../../models/video_model.dart';
import '../home_screen.dart';
import 'parts/error_dialog.dart';
import 'video_detail_display_alert.dart';
import 'youtube_dialog.dart';

class VideoSearchResultAlert extends ConsumerStatefulWidget {
  const VideoSearchResultAlert({super.key});

  @override
  ConsumerState<VideoSearchResultAlert> createState() =>
      _VideoSearchResultAlertState();
}

class _VideoSearchResultAlertState
    extends ConsumerState<VideoSearchResultAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(width: context.screenSize.width),
            Expanded(child: displaySearchVideoList()),
          ],
        ),
      ),
    );
  }

  ///
  Widget displaySearchVideoList() {
    final Map<String, VideoModel> videoModelMap = ref
        .watch(videoProvider.select((VideoState value) => value.videoModelMap));

    final List<String> youtubeIdList = ref.watch(
        searchProvider.select((SearchState value) => value.youtubeIdList));

    final List<String> searchResultAlertDropdownValue = ref.watch(searchProvider
        .select((SearchState value) => value.searchResultAlertDropdownValue));

    final List<String> bunruiList = getBunruiList();
    bunruiList.sort();

    final List<String> selectedYoutubeIdList = ref.watch(videoProvider
        .select((VideoState value) => value.selectedYoutubeIdList));

    final String searchWord = ref
        .read(searchProvider.select((SearchState value) => value.searchWord));

    final RegExp reg = RegExp(searchWord);

    final List<Widget> list = <Widget>[];

    for (int i = 0; i < youtubeIdList.length; i++) {
      if (videoModelMap[youtubeIdList[i]] != null) {
        list.add(GestureDetector(
          onLongPress: () {
            YoutubeDialog(
              context: context,
              widget: VideoDetailDisplayAlert(
                  videoModel: videoModelMap[youtubeIdList[i]]!),
              paddingTop: context.screenSize.height * 0.1,
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: (selectedYoutubeIdList.contains(youtubeIdList[i]))
                  ? Colors.greenAccent.withOpacity(0.1)
                  : Colors.black.withOpacity(0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: context.screenSize.height / 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://img.youtube.com/vi/${youtubeIdList[i]}/mqdefault.jpg',
                          placeholder: (BuildContext context, String url) =>
                              Image.asset('assets/images/no_image.png'),
                          errorWidget: (BuildContext context, String url,
                                  Object error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              videoModelMap[youtubeIdList[i]]!.title,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  videoModelMap[youtubeIdList[i]]!.channelId,
                  style: const TextStyle(fontSize: 12),
                ),

                Text(
                  videoModelMap[youtubeIdList[i]]!.channelTitle,
                  style: const TextStyle(fontSize: 12),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Text(
                      videoModelMap[youtubeIdList[i]]!.playtime,
                      style: const TextStyle(
                          color: Colors.yellowAccent, fontSize: 12),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      videoModelMap[youtubeIdList[i]]!.bunrui,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Container(),
                  ],
                ),
                // ignore: always_specify_types
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: always_specify_types
                    DropdownButton(
                      dropdownColor: Colors.pinkAccent.withOpacity(0.2),
                      items: bunruiList.map((String e) {
                        // ignore: always_specify_types
                        return DropdownMenuItem(
                          value: e,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: (reg.firstMatch(e) != null)
                                      ? Colors.yellowAccent
                                      : Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                      value: searchResultAlertDropdownValue[i],
                      onChanged: (String? value) {
                        ref
                            .read(searchProvider.notifier)
                            .setSearchResultAlertDropdownValue(
                                index: i, bunrui: value!);
                      },
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            final CategoryModel categoryModel = ref
                                .watch(categoryProvider.select(
                                    (CategoryState value) =>
                                        value.categoryList))
                                .firstWhere((CategoryModel e) =>
                                    e.bunrui ==
                                    searchResultAlertDropdownValue[i]);

                            await ref
                                .read(categoryProvider.notifier)
                                .inputBunruiCategory(
                                    youtubeId: youtubeIdList[i],
                                    cate1: categoryModel.category1,
                                    cate2: categoryModel.category2,
                                    bunrui: categoryModel.bunrui);

                            await ref
                                .read(videoProvider.notifier)
                                .getYoutubeList();
                          },
                          child: Icon(Icons.refresh,
                              color: Colors.white.withOpacity(0.4)),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      ref.read(videoProvider.notifier).setSelectedYoutubeIdList(
                          youtubeId: youtubeIdList[i]);
                    },
                    icon: Icon(
                      FontAwesomeIcons.circlePlus,
                      color: (selectedYoutubeIdList.contains(youtubeIdList[i]))
                          ? Colors.greenAccent.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          title: const Text(''),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    if (selectedYoutubeIdList.isEmpty) {
                      // ignore: always_specify_types
                      Future.delayed(
                        Duration.zero,
                        () {
                          if (mounted) {
                            return error_dialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                title: '登録できません。',
                                content: '動画が選択されていません。');
                          }
                        },
                      );

                      return;
                    }

                    await ref
                        .read(videoProvider.notifier)
                        .manipulateVideoList(bunrui: 'special');

                    ref.read(videoProvider.notifier).getYoutubeList();

                    ref
                        .read(videoProvider.notifier)
                        .clearSelectedYoutubeIdList();

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green[900]?.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('選出', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    if (selectedYoutubeIdList.isEmpty) {
                      // ignore: always_specify_types
                      Future.delayed(
                        Duration.zero,
                        () {
                          if (mounted) {
                            return error_dialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                title: '登録できません。',
                                content: '動画が選択されていません。');
                          }
                        },
                      );

                      return;
                    }

                    await ref
                        .read(videoProvider.notifier)
                        .manipulateVideoList(bunrui: 'erase');

                    ref.read(videoProvider.notifier).getYoutubeList();

                    ref
                        .read(videoProvider.notifier)
                        .clearSelectedYoutubeIdList();

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      // ignore: inference_failure_on_instance_creation, always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green[900]?.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('分類消去', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    if (selectedYoutubeIdList.isEmpty) {
                      // ignore: always_specify_types
                      Future.delayed(
                        Duration.zero,
                        () {
                          if (mounted) {
                            return error_dialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                title: '登録できません。',
                                content: '動画が選択されていません。');
                          }
                        },
                      );

                      return;
                    }

                    await ref
                        .read(videoProvider.notifier)
                        .manipulateVideoList(bunrui: 'delete');

                    ref.read(videoProvider.notifier).getYoutubeList();

                    ref
                        .read(videoProvider.notifier)
                        .clearSelectedYoutubeIdList();

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green[900]?.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('削除', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => list[index],
            childCount: list.length,
          ),
        ),
      ],
    );
  }

  ///
  List<String> getBunruiList() {
    final List<String> list = <String>[''];

    ref
        .watch(categoryProvider
            .select((CategoryState value) => value.categoryList))
        .forEach((CategoryModel element) {
      if (!list.contains(element.bunrui)) {
        list.add(element.bunrui);
      }
    });

    return list;
  }
}
