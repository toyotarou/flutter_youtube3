import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/video/video.dart';
import '../../extensions/extensions.dart';
import '../../models/video_model.dart';
import '../home_screen.dart';
import 'video_detail_display_alert.dart';
import 'youtube_dialog.dart';

class BunruiDetailDisplayAlert extends ConsumerStatefulWidget {
  const BunruiDetailDisplayAlert({super.key, required this.bunrui});

  final String bunrui;

  @override
  ConsumerState<BunruiDetailDisplayAlert> createState() =>
      _BunruiDetailDisplayAlertState();
}

class _BunruiDetailDisplayAlertState
    extends ConsumerState<BunruiDetailDisplayAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),
            Text(widget.bunrui),
            Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
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
                            builder: (BuildContext context) =>
                                const HomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green[900]?.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            const Text('分類消去', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
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
            const SizedBox(height: 10),
            Expanded(child: displayBunruiDetail()),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayBunruiDetail() {
    final Map<String, List<VideoModel>> videoListMap = ref
        .watch(videoProvider.select((VideoState value) => value.videoListMap));

    if (videoListMap[widget.bunrui] == null) {
      return Container();
    }

    final List<Widget> list = <Widget>[];

    final List<String> selectedYoutubeIdList = ref.watch(videoProvider
        .select((VideoState value) => value.selectedYoutubeIdList));

    videoListMap[widget.bunrui]?.forEach((VideoModel element) {
      list.add(GestureDetector(
        onLongPress: () {
          YoutubeDialog(
            context: context,
            widget: VideoDetailDisplayAlert(videoModel: element),
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
            color: Colors.black.withOpacity(0.3),
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://img.youtube.com/vi/${element.youtubeId}/mqdefault.jpg',
                          placeholder: (BuildContext context, String url) =>
                              Image.asset('assets/images/no_image.png'),
                          errorWidget: (BuildContext context, String url,
                                  Object error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        element.playtime,
                        style: const TextStyle(
                            color: Colors.yellowAccent, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          element.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Divider(color: Colors.white),
                        DefaultTextStyle(
                          style: const TextStyle(fontSize: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(element.channelId),
                              Text(element.channelTitle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  GestureDetector(
                    onTap: () {
                      ref.read(videoProvider.notifier).setSelectedYoutubeIdList(
                          youtubeId: element.youtubeId);
                    },
                    child: Icon(
                      FontAwesomeIcons.circlePlus,
                      color: (selectedYoutubeIdList.contains(element.youtubeId))
                          ? Colors.greenAccent.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    });

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => list[index],
            childCount: list.length,
          ),
        ),
      ],
    );
  }
}
