import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/video/video.dart';
import '../../models/video_model.dart';
import 'page/yearly_calendar_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class YearlyCalendarAlert extends ConsumerStatefulWidget {
  const YearlyCalendarAlert({super.key});

  @override
  ConsumerState<YearlyCalendarAlert> createState() =>
      _YearlyCalendarAlertState();
}

class _YearlyCalendarAlertState extends ConsumerState<YearlyCalendarAlert> {
  List<TabInfo> tabs = <TabInfo>[];

  ///
  @override
  void initState() {
    super.initState();

    // ignore: always_specify_types
    Future(() {
      ref.read(videoProvider.notifier).getYoutubeList();
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    makeTab();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(Icons.check_box_outline_blank,
                color: Colors.transparent),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(children: tabs.map((TabInfo tab) => tab.widget).toList()),
      ),
    );
  }

  ///
  void makeTab() {
    final Map<String, List<VideoModel>> videoListMap =
        ref.watch(videoProvider.select((VideoState value) => value.videoListMap));

    final List<int> yearList = <int>[];
    videoListMap.forEach((String key, List<VideoModel> value) {
      for (final VideoModel element in value) {
        yearList.add(int.parse(element.getdate.substring(0, 4)));

        if (element.pubdate != null) {
          yearList.add(int.parse(element.pubdate.toString().split('-')[0]));
        }
      }
    });

    yearList.sort();

    tabs = <TabInfo>[];

    final List<int> list = <int>[];

    for (int i = yearList[0]; i <= DateTime.now().year; i++) {
      list.add(i);
    }

    list
      ..sort((int a, int b) => -1 * a.compareTo(b))
      ..forEach((int element) {
        tabs.add(
          TabInfo(
            element.toString(),
            YearlyCalendarPage(date: DateTime(element)),
          ),
        );
      });
  }
}
