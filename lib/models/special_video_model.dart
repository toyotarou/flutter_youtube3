import '../extensions/extensions.dart';
import 'video_model.dart';

class SpecialVideoModel {
  SpecialVideoModel({
    required this.bunrui,
    required this.count,
    required this.item,
  });

  factory SpecialVideoModel.fromJson(Map<String, dynamic> json) => SpecialVideoModel(
        bunrui: json['bunrui'].toString(),
        count: json['count'].toString().toInt(),
        item: List<VideoModel>.from((json['item'] as List<VideoModel>)
            .map((VideoModel x) => VideoModel.fromJson(x as Map<String, dynamic>))),
      );
  String bunrui;
  int count;
  List<VideoModel> item;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bunrui': bunrui,
        'count': count,
        'item': List<dynamic>.from(item.map((VideoModel x) => x.toJson())),
      };
}
