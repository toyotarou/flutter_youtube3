import '../extensions/extensions.dart';

class HolidayModel {
  HolidayModel({required this.data});

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
        data: List<DateTime>.from(
            // ignore: always_specify_types
            (json['data'] as List<String>).map((String x) => x.toDateTime())
                // ignore: always_specify_types
                as Iterable),
      );

  List<DateTime> data;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': List<dynamic>.from(data.map((DateTime x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
      };
}
