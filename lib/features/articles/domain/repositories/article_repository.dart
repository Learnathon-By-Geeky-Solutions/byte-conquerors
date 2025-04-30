import 'package:dartz/dartz.dart';
import 'package:soul_space/features/articles/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Exception, List<Article>>> getArticles();
  Future<Either<Exception, void>> addFavorite(String articleId);
  Future<Either<Exception, void>> removeFavorite(String articleId);
}
