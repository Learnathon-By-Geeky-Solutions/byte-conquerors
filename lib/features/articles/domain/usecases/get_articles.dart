import 'package:dartz/dartz.dart';
import 'package:soul_space/features/articles/domain/entities/article.dart';
import 'package:soul_space/features/articles/domain/repositories/article_repository.dart';

class GetArticles {
  final ArticleRepository repository;

  GetArticles(this.repository);

  Future<Either<Exception, List<Article>>> call() async {
    return await repository.getArticles();
  }
}
