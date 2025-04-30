import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String url;
  final bool isFavorite;

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [id, title, description, url, isFavorite];

  // From JSON to ArticleModel
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'isFavorite': isFavorite,
    };
  }
}
