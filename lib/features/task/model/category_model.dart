class CategoryModel {
  final String id;
  final String title;
  final String icon;

  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
    );
  }

  // Define the copyWith method
  CategoryModel copyWith({
    String? id,
    String? title,
    String? icon,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }
}
