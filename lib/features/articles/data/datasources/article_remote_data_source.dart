import 'package:dio/dio.dart';
import 'package:soul_space/features/articles/data/models/article_model.dart';

/// Abstract class (interface) to define the contract for fetching articles.
abstract class IArticleRemoteDataSource {
  Future<List<ArticleModel>> fetchArticles();
}

/// Concrete implementation that uses Dio to fetch articles from API.
class ArticleRemoteDataSourceImpl implements IArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await dio.get('https://api.example.com/articles');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => ArticleModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }
}
