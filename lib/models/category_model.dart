class CategoryModel {
  CategoryModel({
    required this.category1,
    required this.category2,
    required this.bunrui,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        category1: json['category1'].toString(),
        category2: json['category2'].toString(),
        bunrui: json['bunrui'].toString(),
      );

  String category1;
  String category2;
  String bunrui;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'category1': category1,
        'category2': category2,
        'bunrui': bunrui,
      };
}
