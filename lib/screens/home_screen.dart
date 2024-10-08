import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/category/category.dart';
import '../controllers/search/search.dart';
import '../controllers/video/video.dart';
import '../extensions/extensions.dart';
import '../models/category_model.dart';
import '../models/special_video_model.dart';
import '../models/video_model.dart';
import '../utility/utility.dart';
import 'components/bunrui_detail_display_alert.dart';
import 'components/new_category_input_alert.dart';
import 'components/video_detail_display_alert.dart';
import 'components/video_search_result_alert.dart';
import 'components/yearly_calendar_alert.dart';
import 'components/youtube_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _BunruiScreenState();
}

class _BunruiScreenState extends ConsumerState<HomeScreen> {
  List<String> bunruiLevelList = <String>[];

  TextEditingController searchWordEditingController = TextEditingController();

  Utility utility = Utility();

  List<ScrollController> _scrollControllers = <ScrollController>[];

  final ScrollController homeListScrollController = ScrollController();

  ///
  @override
  void initState() {
    super.initState();

    // ignore: always_specify_types
    Future(() {
      ref.read(videoProvider.notifier).getBunruiBlankVideo();

      ref.read(videoProvider.notifier).getYoutubeList();

      ref.read(videoProvider.notifier).getSpecialVideo();

      ref.read(categoryProvider.notifier).getCategory();

      ref.read(categoryProvider.notifier).setSelectedCategory1(category1: '');
      ref.read(categoryProvider.notifier).setSelectedCategory2(category2: '');

      ref.read(categoryProvider.notifier).clearAdditionalCategoryList();
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final List<String> category1List = <String>['NEW'];

    final List<CategoryModel> categoryList2 = <CategoryModel>[...categoryList];

    final List<CategoryModel> additionalCategoryList = ref.watch(
        categoryProvider
            .select((CategoryState value) => value.additionalCategoryList));

    for (final CategoryModel element in additionalCategoryList) {
      categoryList2.add(
        CategoryModel(
          category1: element.category1,
          category2: element.category2,
          bunrui: element.bunrui,
        ),
      );
    }

    for (final CategoryModel element in categoryList2) {
      if (!category1List.contains(element.category1)) {
        category1List.add(element.category1);
      }
    }

    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    final List<VideoModel> bunruiBlankVideoList =
        ref.watch(videoProvider.select((VideoState value) => value.videoList));

    category1List.sort();

    final String searchTarget = ref.watch(
        searchProvider.select((SearchState value) => value.searchTarget));

    // ignore: always_specify_types
    _scrollControllers = List.generate(1000, (int index) => ScrollController());

    final String selectedCategory2 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Youtube Video List'),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          ref
                              .read(searchProvider.notifier)
                              .setSearchTarget(target: 'title');
                        },
                        icon: Icon(
                          Icons.title,
                          color: (searchTarget == 'title')
                              ? Colors.yellowAccent
                              : Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(searchProvider.notifier)
                              .setSearchTarget(target: 'channel');
                        },
                        icon: Icon(
                          Icons.nature_outlined,
                          color: (searchTarget == 'channel')
                              ? Colors.yellowAccent
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TextField(
                  controller: searchWordEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: 'word',
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (PointerDownEvent event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                )),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    if (searchWordEditingController.text.trim() != '') {
                      ref.read(searchProvider.notifier).getSearchYoutubeId(
                          word: searchWordEditingController.text);

                      searchWordEditingController.clear();

                      ref
                          .read(searchProvider.notifier)
                          .clearSearchResultAlertDropdownValue();

                      YoutubeDialog(
                        context: context,
                        widget: const VideoSearchResultAlert(),
                      );
                    }
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
        flexibleSpace: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => YoutubeDialog(
                context: context, widget: const YearlyCalendarAlert()),
            icon: const Icon(Icons.calendar_month),
          ),
          IconButton(
            onPressed: () {
              ref.read(videoProvider.notifier).clearSelectedYoutubeIdList();

              Navigator.pushReplacement(
                  context,
                  // ignore: inference_failure_on_instance_creation, always_specify_types
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen()));
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.yellowAccent.withOpacity(0.4),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          utility.getBackGround(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: category1List.map((String e) {
                                return GestureDetector(
                                  onTap: (e == 'NEW')
                                      ? () {
                                          YoutubeDialog(
                                            context: context,
                                            widget: const NewCategoryInputAlert(
                                                flag: 'category1'),
                                          );
                                        }
                                      : () {
                                          ref
                                              .read(categoryProvider.notifier)
                                              .setSelectedCategory2(
                                                  category2: '');

                                          ref
                                              .read(categoryProvider.notifier)
                                              .setSelectedCategory1(
                                                  category1: e);
                                        },
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: (e == 'NEW')
                                            ? Colors.blueAccent.withOpacity(0.2)
                                            : (selectedCategory1 == e)
                                                ? Colors.yellowAccent
                                                    .withOpacity(0.2)
                                                : Colors.greenAccent
                                                    .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(e)),
                                );
                              }).toList()),
                        ),
                      ),
                      SizedBox(child: displayCategory2Widget()),
                      SizedBox(
                        height:
                            (selectedCategory1 == '' && selectedCategory2 == '')
                                ? context.screenSize.height * 0.7
                                : context.screenSize.height * 0.6,
                        child: Column(
                          children: <Widget>[
                            Expanded(child: displayLeftList())
                          ],
                        ),
                      ),
                      if (bunruiBlankVideoList.isNotEmpty) ...<Widget>[
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.pinkAccent.withOpacity(0.2)),
                          onPressed: () async {
                            final Map<String, CategoryModel>
                                bunruiBlankSettingMap = await ref.read(
                                    videoProvider.select((VideoState value) =>
                                        value.bunruiBlankSettingMap));

                            bunruiBlankSettingMap.forEach(
                                (String key, CategoryModel value) async {
                              await ref
                                  .read(categoryProvider.notifier)
                                  .inputBunruiCategory(
                                    youtubeId: key,
                                    cate1: value.category1,
                                    cate2: value.category2,
                                    bunrui: value.bunrui,
                                  );
                            });

                            await ref
                                .read(videoProvider.notifier)
                                .getYoutubeList();

                            ref.read(videoProvider.notifier).clearVideoList();

                            ref
                                .read(videoProvider.notifier)
                                .clearSelectedYoutubeIdList();

                            Navigator.pushReplacement(
                              // ignore: use_build_context_synchronously
                              context,
                              // ignore: inference_failure_on_instance_creation, always_specify_types
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text('input'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (bunruiBlankVideoList.isNotEmpty) ...<Widget>[
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.greenAccent.withOpacity(0.2),
                            width: 3,
                          ),
                        ),
                      ),
                      height: context.screenSize.height * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Expanded(child: displayRightList())],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget displayLeftList() {
    final List<Widget> list = <Widget>[];

    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    final String selectedCategory2 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    if (selectedCategory1 == '' && selectedCategory2 == '') {
      //---------------------// starItemList

      final List<SpecialVideoModel> specialModelList = ref.watch(
          videoProvider.select((VideoState value) => value.specialModelList));

      for (final SpecialVideoModel element in specialModelList) {
        list.add(Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration:
                      BoxDecoration(color: Colors.blueAccent.withOpacity(0.2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(element.bunrui),
                      Text(element.item.length.toString()),
                    ],
                  ),
                ),
              ),
              if (element.item.isNotEmpty) ...<Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: element.item.map((VideoModel e) {
                    return GestureDetector(
                      onLongPress: () => YoutubeDialog(
                          context: context,
                          widget: VideoDetailDisplayAlert(videoModel: e)),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: context.screenSize.width * 0.2,
                              padding: const EdgeInsets.all(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://img.youtube.com/vi/${e.youtubeId}/mqdefault.jpg',
                                placeholder: (BuildContext context,
                                        String url) =>
                                    Image.asset('assets/images/no_image.png'),
                                errorWidget: (BuildContext context, String url,
                                        Object error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: context.screenSize.height / 20),
                              child: Text(
                                e.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            )),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ));
      }

      //================================//
    } else {
      bunruiLevelList.clear();

      final List<CategoryModel> additionalCategoryList = ref.watch(
          categoryProvider
              .select((CategoryState value) => value.additionalCategoryList));

      for (final CategoryModel element in additionalCategoryList) {
        if (element.category1 == selectedCategory1 &&
            element.category2 == selectedCategory2) {
          bunruiLevelList.add(element.bunrui);
        }
      }

      final List<CategoryModel> categoryList = ref.watch(
          categoryProvider.select((CategoryState value) => value.categoryList));

      for (final CategoryModel element in categoryList) {
        if (element.category2 == selectedCategory2) {
          if (!bunruiLevelList.contains(element.bunrui)) {
            bunruiLevelList.add(element.bunrui);
          }
        }
      }

      final Map<String, List<VideoModel>> videoListMap = ref.watch(
          videoProvider.select((VideoState value) => value.videoListMap));

      final List<VideoModel> bunruiBlankVideoList = ref
          .watch(videoProvider.select((VideoState value) => value.videoList));

      list.add(
        GestureDetector(
          onTap: () {
            YoutubeDialog(
              context: context,
              widget: const NewCategoryInputAlert(flag: 'bunrui'),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('NEW'),
              ),
              Container(),
            ],
          ),
        ),
      );

      list.add(const SizedBox(height: 10));

      bunruiLevelList = bunruiLevelList.toSet().toList();

      for (int i = 0; i < bunruiLevelList.length; i++) {
        list.add(Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          margin: (bunruiBlankVideoList.isEmpty)
              ? const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 50)
              : const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(5),
          width: (bunruiBlankVideoList.isEmpty)
              ? double.infinity
              : context.screenSize.width * 0.52,
          height: 250,
          child: DragTarget<VideoModel>(
            // ignore: unnecessary_null_comparison
            onWillAcceptWithDetails: (DragTargetDetails<VideoModel> data) =>
                // ignore: unnecessary_null_comparison
                null != data,
            // ignore: deprecated_member_use
            onAccept: (VideoModel data) {
              ref.read(videoProvider.notifier).addVideoListMap(
                  bunrui: bunruiLevelList[i], videoModel: data);

              ref.read(videoProvider.notifier).setBunruiBlankSettingMap(
                    category1: selectedCategory1,
                    category2: selectedCategory2,
                    bunrui: bunruiLevelList[i],
                    youtubeId: data.youtubeId,
                  );
            },

            builder: (BuildContext context, List<VideoModel?> candidateData,
                List<dynamic> rejectedData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      YoutubeDialog(
                        context: context,
                        widget: BunruiDetailDisplayAlert(
                            bunrui: bunruiLevelList[i]),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(bunruiLevelList[i]),
                          Text((videoListMap[bunruiLevelList[i]] != null)
                              ? videoListMap[bunruiLevelList[i]]!
                                  .length
                                  .toString()
                              : '0')
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollControllers[i],
                      child: SingleChildScrollView(
                        controller: _scrollControllers[i],
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                              children:
                                  getVideoList(bunrui: bunruiLevelList[i])),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
      }

      list.add(const SizedBox(height: 40));
    }

    return Scrollbar(
      controller: homeListScrollController,
      thumbVisibility: true,
      child: CustomScrollView(
        controller: homeListScrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => list[index],
              childCount: list.length,
            ),
          ),
        ],
      ),
    );
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
        list.add(
          GestureDetector(
            onLongPress: () {
              YoutubeDialog(
                context: context,
                widget: VideoDetailDisplayAlert(videoModel: element),
                paddingTop: context.screenSize.height * 0.1,
              );
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: context.screenSize.width * 0.25,
                  padding: const EdgeInsets.all(5),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://img.youtube.com/vi/${element.youtubeId}/mqdefault.jpg',
                    placeholder: (BuildContext context, String url) =>
                        Image.asset('assets/images/no_image.png'),
                    errorWidget:
                        (BuildContext context, String url, Object error) =>
                            const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    Icons.star,
                    color: (element.special == '1')
                        ? Colors.greenAccent
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return list;
  }

  ///
  Widget buildDraggable({required VideoModel videoModel}) {
    // ignore: always_specify_types
    return GestureDetector(
      onLongPress: () {
        YoutubeDialog(
          context: context,
          widget: VideoDetailDisplayAlert(videoModel: videoModel),
          paddingTop: context.screenSize.height * 0.1,
        );
      },
      // ignore: always_specify_types
      child: Draggable(
        data: videoModel,
        feedback: Container(
          width: 50,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          height: 50,
          color: Colors.blueAccent.withOpacity(0.5),
          child: const Scaffold(body: Center(child: Icon(Icons.movie))),
        ),
        childWhenDragging: Container(
          width: 110,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          height: 50,
          color: Colors.white.withOpacity(0.1),
          child: Text(
            '',
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
        ),
        child: Container(
          width: 110,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            child: CachedNetworkImage(
              imageUrl:
                  'https://img.youtube.com/vi/${videoModel.youtubeId}/mqdefault.jpg',
              placeholder: (BuildContext context, String url) =>
                  Image.asset('assets/images/no_image.png'),
              errorWidget: (BuildContext context, String url, Object error) =>
                  const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayRightList() {
    final List<VideoModel> bunruiBlankVideoList =
        ref.watch(videoProvider.select((VideoState value) => value.videoList));

    final List<Widget> list = <Widget>[];

    final Map<String, List<VideoModel>> videoListMap = ref
        .watch(videoProvider.select((VideoState value) => value.videoListMap));

    final List<String> jogaiVideoList = <String>[];
    videoListMap.forEach((String key, List<VideoModel> value) {
      for (final VideoModel element in value) {
        if (element.bunrui != '0') {
          jogaiVideoList.add(element.title);
        }
      }
    });

    for (final VideoModel element in bunruiBlankVideoList) {
      if (!jogaiVideoList.contains(element.title)) {
        list.add(buildDraggable(videoModel: element));
      }
    }

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: list),
      ),
    );
  }

  ///
  Widget displayCategory2Widget() {
    final String selectedCategory1 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory1));

    if (selectedCategory1 == '') {
      return Container();
    }

    final List<Widget> list = <Widget>[];

    final List<CategoryModel> categoryList = ref.watch(
        categoryProvider.select((CategoryState value) => value.categoryList));

    final String selectedCategory2 = ref.watch(categoryProvider
        .select((CategoryState value) => value.selectedCategory2));

    final List<String> category2List = <String>['NEW'];

    final List<CategoryModel> categoryList2 = <CategoryModel>[...categoryList];

    final List<CategoryModel> additionalCategoryList = ref.watch(
        categoryProvider
            .select((CategoryState value) => value.additionalCategoryList));

    // ignore: prefer_foreach
    for (final CategoryModel element in additionalCategoryList) {
      categoryList2.add(element);
    }

    for (final CategoryModel element in categoryList2) {
      if (element.category1 == selectedCategory1) {
        if (!category2List.contains(element.category2)) {
          category2List.add(element.category2);
        }
      }
    }

    for (final String element in category2List) {
      list.add(GestureDetector(
        onTap: (element == 'NEW')
            ? () {
                YoutubeDialog(
                  context: context,
                  widget: const NewCategoryInputAlert(flag: 'category2'),
                );
              }
            : () {
                bunruiLevelList.clear();

                ref
                    .read(categoryProvider.notifier)
                    .setSelectedCategory2(category2: element);
              },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: (element == 'NEW')
                ? Colors.blueAccent.withOpacity(0.2)
                : (selectedCategory2 == element)
                    ? Colors.yellowAccent.withOpacity(0.2)
                    : Colors.greenAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(element),
        ),
      ));
    }

    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: list),
      ),
    );
  }
}
