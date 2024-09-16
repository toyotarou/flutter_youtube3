import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/video/video.dart';
import '../../extensions/extensions.dart';
import '../../models/video_model.dart';

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
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),
            Expanded(child: displayBunruiDetail()),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayBunruiDetail() {
    final List<Widget> list = <Widget>[];

    final Map<String, List<VideoModel>> videoListMap = ref
        .watch(videoProvider.select((VideoState value) => value.videoListMap));

    if (videoListMap[widget.bunrui] != null) {
      for (final VideoModel element in videoListMap[widget.bunrui]!) {
        list.add(Text(element.title));
      }
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
