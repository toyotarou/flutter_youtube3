import '../extensions/extensions.dart';
import 'video.dart';

class SpecialVideo {
  SpecialVideo({
    required this.bunrui,
    required this.count,
    required this.item,
  });

  factory SpecialVideo.fromJson(Map<String, dynamic> json) => SpecialVideo(
        bunrui: json['bunrui'].toString(),
        count: json['count'].toString().toInt(),
        item: List<Video>.from((json['item'] as List<Video>)
            .map((Video x) => Video.fromJson(x as Map<String, dynamic>))),
      );
  String bunrui;
  int count;
  List<Video> item;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bunrui': bunrui,
        'count': count,
        'item': List<dynamic>.from(item.map((Video x) => x.toJson())),
      };
}
