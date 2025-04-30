class Article {
  final String id;
  final String title;
  final String description;
  final String url;
  final bool isFavorite;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.isFavorite,
  });

  Article copyWith({
    String? id,
    String? title,
    String? description,
    String? url,
    bool? isFavorite,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
