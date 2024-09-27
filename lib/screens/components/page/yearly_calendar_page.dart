import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/video/video.dart';
import '../../../extensions/extensions.dart';
import '../../../models/video_model.dart';
import '../calendar_video_list_alert.dart';
import '../youtube_dialog.dart';

class YearlyCalendarPage extends ConsumerStatefulWidget {
  const YearlyCalendarPage({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<YearlyCalendarPage> createState() => _YearlyCalendarPageState();
}

class _YearlyCalendarPageState extends ConsumerState<YearlyCalendarPage> {
  DateTime yearFirst = DateTime.now();

  List<String> youbiList = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  List<String> days = <String>[];

  Map<String, List<VideoModel>> publishDateVideoMap =
      <String, List<VideoModel>>{};

  Map<String, List<VideoModel>> getDateVideoMap = <String, List<VideoModel>>{};

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
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Row(
                      children: [
                        Text(
                          'publish',
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                        Text(' / '),
                        Text(
                          'get',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: _getCalendar()),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _getCalendar() {
    publishDateVideoMap = ref.watch(
        videoProvider.select((VideoState value) => value.publishDateVideoMap));

    getDateVideoMap = ref.watch(
        videoProvider.select((VideoState value) => value.getDateVideoMap));

    yearFirst = DateTime(widget.date.yyyy.toInt());

    final DateTime yearEnd = DateTime(yearFirst.year + 1, 1, 0);

    final int diff = yearEnd.difference(yearFirst).inDays;
    final int yearDaysNum = diff + 1;

    final String youbi = yearFirst.youbiStr;
    final int youbiNum =
        youbiList.indexWhere((String element) => element == youbi);

    final int weekNum = ((yearDaysNum + youbiNum) / 7).ceil();

    // ignore: always_specify_types
    days = List.generate(weekNum * 7, (int index) => '');

    for (int i = 0; i < (weekNum * 7); i++) {
      if (i >= youbiNum) {
        final DateTime gendate = yearFirst.add(Duration(days: i - youbiNum));

        if (yearFirst.year == gendate.year) {
          days[i] = gendate.mmdd;
        }
      }
    }

    final List<Widget> list = <Widget>[];
    for (int i = 0; i < weekNum; i++) {
      list.add(_getRow(days: days, rowNum: i));
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Widget _getRow({required List<String> days, required int rowNum}) {
    final List<Widget> list = <Widget>[];

    for (int i = rowNum * 7; i < ((rowNum + 1) * 7); i++) {
      final List<String> exDays =
          (days[i] == '') ? <String>[] : days[i].split('-');

      final int publishVideoNum =
          (publishDateVideoMap['${widget.date.year}-${days[i]}'] != null)
              ? publishDateVideoMap['${widget.date.year}-${days[i]}']!.length
              : 0;

      final int getVideoNum =
          (getDateVideoMap['${widget.date.year}-${days[i]}'] != null)
              ? getDateVideoMap['${widget.date.year}-${days[i]}']!.length
              : 0;

      list.add(
        Expanded(
          child: (days[i] == '')
              ? Container()
              : GestureDetector(
                  onTap: (publishVideoNum > 0 || getVideoNum > 0)
                      ? () async {
                          YoutubeDialog(
                            context: context,
                            widget: CalendarVideoListAlert(
                              publishVideoList: publishDateVideoMap[
                                  '${widget.date.year}-${days[i]}'],
                              getVideoList: getDateVideoMap[
                                  '${widget.date.year}-${days[i]}'],
                            ),
                            clearBarrierColor: true,
                          );
                        }
                      : null,
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                    decoration:
                        BoxDecoration(border: _getBorder(mmdd: days[i])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: context.screenSize.height / 40),
                          child: Text(
                            (exDays[1] == '01') ? exDays[0] : days[i],
                            style: TextStyle(
                              fontSize: (exDays[1] == '01') ? 12 : 8,
                              color: (exDays[1] == '01')
                                  ? const Color(0xFFFBB6CE)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              publishVideoNum.toString(),
                              style: TextStyle(
                                  color: (publishVideoNum == 0)
                                      ? Colors.transparent
                                      : Colors.greenAccent),
                            ),
                            Text(
                              getVideoNum.toString(),
                              style: TextStyle(
                                  color: (getVideoNum == 0)
                                      ? Colors.transparent
                                      : Colors.blueAccent),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  ///
  Border _getBorder({required String mmdd}) {
    final DateTime genDate = DateTime.parse('${widget.date.yyyy}-$mmdd');

    return (genDate.yyyymmdd == DateTime.now().yyyymmdd)
        ? Border.all(color: Colors.orangeAccent.withOpacity(0.4), width: 2)
        : Border.all(color: Colors.white.withOpacity(0.2), width: 2);
  }
}
