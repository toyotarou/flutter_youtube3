class VideoModel {
  VideoModel({
    required this.youtubeId,
    required this.title,
    required this.getdate,
    required this.url,
    required this.bunrui,
    required this.special,
    required this.pubdate,
    required this.channelId,
    required this.channelTitle,
    required this.playtime,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        youtubeId:
            (json['youtube_id'] != null) ? json['youtube_id'].toString() : '',
        title: (json['title'] != null) ? json['title'].toString() : '',
        getdate: (json['getdate'] != null) ? json['getdate'].toString() : '',
        url: (json['url'] != null) ? json['url'].toString() : '',
        bunrui: (json['bunrui'] != null) ? json['bunrui'].toString() : '',
        special: (json['special'] != null) ? json['special'].toString() : '',
        pubdate: (json['pubdate'] != null)
            ? DateTime.parse(json['pubdate'].toString())
            : null,
        channelId:
            (json['channel_id'] != null) ? json['channel_id'].toString() : '',
        channelTitle: (json['channel_title'] != null)
            ? json['channel_title'].toString()
            : '',
        playtime: (json['playtime'] != null) ? json['playtime'].toString() : '',
      );
  String youtubeId;
  String title;
  String getdate;
  String url;
  String bunrui;
  String special;
  DateTime? pubdate;
  String channelId;
  String channelTitle;
  String playtime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'youtube_id': youtubeId,
        'title': title,
        'getdate': getdate,
        'url': url,
        'bunrui': bunrui,
        'special': special,
        'pubdate':
            "${pubdate!.year.toString().padLeft(4, '0')}-${pubdate!.month.toString().padLeft(2, '0')}-${pubdate!.day.toString().padLeft(2, '0')}",
        'channel_id': channelId,
        'channel_title': channelTitle,
        'playtime': playtime,
      };
}
