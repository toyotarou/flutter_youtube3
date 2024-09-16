import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/category/category.dart';
import '../controllers/video/video.dart';
import '../extensions/extensions.dart';
import '../models/category_model.dart';
import '../models/video_model.dart';

class BunruiScreen extends ConsumerStatefulWidget {
  const BunruiScreen({super.key});

  @override
  ConsumerState<BunruiScreen> createState() => _BunruiScreenState();
}

class _BunruiScreenState extends ConsumerState<BunruiScreen> {
  List<String> bunruiLevelList = <String>[];

  ///
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final List<String> category1List = <String>[];
    for (final CategoryModel element in categoryList) {
      if (!category1List.contains(element.category1)) {
        category1List.add(element.category1);
      }
    }

    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    return Scaffold(
      appBar: AppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: category1List.map((String e) {
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(categoryProvider.notifier)
                                    .setSelectedCategory2(category2: '');

                                ref
                                    .read(categoryProvider.notifier)
                                    .setSelectedCategory1(category1: e);
                              },
                              child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: (selectedCategory1 == e)
                                        ? Colors.yellowAccent.withOpacity(0.2)
                                        : Colors.greenAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(e)),
                            );
                          }).toList()),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: displayCategory2Widget(),
                  ),
                  SizedBox(
                    height: context.screenSize.height * 0.8,
                    child: Column(
                      children: <Widget>[
                        Expanded(child: displayLeftList()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.greenAccent.withOpacity(0.4),
                      width: 3,
                    ),
                  ),
                ),
                height: context.screenSize.height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: displayRightList()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  Widget displayLeftList() {
    bunruiLevelList.clear();

    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final String selectedCategory2 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    for (final CategoryModel element in categoryList) {
      if (element.category2 == selectedCategory2) {
        if (!bunruiLevelList.contains(element.bunrui)) {
          bunruiLevelList.add(element.bunrui);
        }
      }
    }

    final List<Widget> list = <Widget>[];

    for (int i = 0; i < bunruiLevelList.length; i++) {
      list.add(Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        height: 200,
        child: DragTarget<VideoModel>(
          // ignore: unnecessary_null_comparison
          onWillAcceptWithDetails: (DragTargetDetails<VideoModel> data) =>
              // ignore: unnecessary_null_comparison
              null != data,
          // ignore: deprecated_member_use
          onAccept: (VideoModel data) {
            setState(() {
              ref.read(videoProvider.notifier).addVideoListMap(
                    bunrui: bunruiLevelList[i],
                    videoModel: data,
                  );
            });
          },

          builder: (BuildContext context, List<VideoModel?> candidateData,
              List<dynamic> rejectedData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(bunruiLevelList[i]),
                  Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                  Wrap(children: getVideoList(bunrui: bunruiLevelList[i])),
                ],
              ),
            );
          },
        ),
      ));
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  List<Widget> getVideoList({required String bunrui}) {
    if (bunrui == '') {
      return <Widget>[];
    }

    final List<Widget> list = <Widget>[];

    final Map<String, List<VideoModel>> videoListMap = ref
        .watch(videoProvider.select((VideoState value) => value.videoListMap));

    if (videoListMap[bunrui] != null) {
      for (final VideoModel element in videoListMap[bunrui]!) {
        list.add(Text(
          element.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
      }
    }

    return list;
  }

  ///
  Widget buildDraggable({required VideoModel videoModel}) {
    // ignore: always_specify_types
    return Draggable(
      data: videoModel,
      feedback: Container(
        width: 50,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 50,
        color: Colors.blueAccent.withOpacity(0.5),
        child: const Scaffold(body: Text('F')),
      ),
      childWhenDragging: Container(
        width: 110,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 50,
        color: Colors.white.withOpacity(0.1),
        child: Text(
          'now dragging',
          style: TextStyle(color: Colors.white.withOpacity(0.6)),
        ),
      ),
      child: Container(
        width: 110,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Text(videoModel.title),
      ),
    );
  }

  ///
  Widget displayRightList() {
    final List<Widget> list = <Widget>[];

    final List<String> jogaiItemList = <String>[];

    final Map<String, List<VideoModel>> videoListMap = ref
        .watch(videoProvider.select((VideoState value) => value.videoListMap));

    videoListMap.forEach((String key, List<VideoModel> value) {
      for (final VideoModel element in value) {
        jogaiItemList.add(element.title);
      }
    });

    for (int i = 0; i < 100; i++) {
      final String item = 'child_$i';

      if (!jogaiItemList.contains(item)) {
        list.add(buildDraggable(
          videoModel: VideoModel(
            youtubeId: '',
            title: item,
            getdate: '',
            url: '',
            bunrui: '',
            special: '',
            pubdate: null,
            channelId: '',
            channelTitle: '',
            playtime: '',
          ),
        ));
      }
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ),
    );
  }

  ///
  Widget displayCategory2Widget() {
    final List<Widget> list = <Widget>[];

    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    if (selectedCategory1 == '') {
      return Align(
        child: Text(
          'select category 1',
          style: TextStyle(color: Colors.white.withOpacity(0.4)),
        ),
      );
    }

    final String selectedCategory2 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    final List<String> category2List = <String>[];
    for (final CategoryModel element in categoryList) {
      if (element.category1 == selectedCategory1) {
        if (!category2List.contains(element.category2)) {
          category2List.add(element.category2);
        }
      }
    }

    for (final String element in category2List) {
      list.add(GestureDetector(
        onTap: () {
          bunruiLevelList.clear();

          ref
              .read(categoryProvider.notifier)
              .setSelectedCategory2(category2: element);
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: (selectedCategory2 == element)
                ? Colors.yellowAccent.withOpacity(0.2)
                : Colors.greenAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(element),
        ),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }
}
