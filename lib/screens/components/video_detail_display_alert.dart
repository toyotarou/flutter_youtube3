import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/video_model.dart';

class VideoDetailDisplayAlert extends ConsumerStatefulWidget {
  const VideoDetailDisplayAlert({super.key, required this.videoModel});

  final VideoModel videoModel;

  @override
  ConsumerState<VideoDetailDisplayAlert> createState() =>
      _VideoDetailDisplayAlertState();
}

class _VideoDetailDisplayAlertState
    extends ConsumerState<VideoDetailDisplayAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Icon(
                      Icons.star,
                      color: (widget.videoModel.special == '1')
                          ? Colors.greenAccent
                          : Colors.grey,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                CachedNetworkImage(
                  imageUrl:
                      'https://img.youtube.com/vi/${widget.videoModel.youtubeId}/mqdefault.jpg',
                  placeholder: (BuildContext context, String url) =>
                      Image.asset('assets/images/no_image.png'),
                  errorWidget: (BuildContext context, String url, Object error) =>
                      const Icon(Icons.error),
                ),
                const SizedBox(height: 10),
                Text(widget.videoModel.youtubeId),
                Text(widget.videoModel.title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Text(
                      widget.videoModel.playtime,
                      style: const TextStyle(color: Colors.yellowAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    if (widget.videoModel.url != '') ...<Widget>[
                      IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.link, size: 40, color: Colors.white),
                      ),
                    ],
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          if (widget.videoModel.pubdate != null) ...<Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('publish date'),
                                Text(widget.videoModel.pubdate!.yyyymmdd),
                              ],
                            ),
                          ],
                          if (widget.videoModel.getdate != '') ...<Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('get date'),
                                Text(
                                    '${widget.videoModel.getdate.substring(0, 4)}-${widget.videoModel.getdate.substring(4, 6)}-${widget.videoModel.getdate.substring(6)}'),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
                Text(widget.videoModel.url),
                Text(widget.videoModel.channelId),
                Text(widget.videoModel.channelTitle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
