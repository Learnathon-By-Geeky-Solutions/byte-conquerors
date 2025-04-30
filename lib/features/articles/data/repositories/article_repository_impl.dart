import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soul_space/features/articles/data/datasources/article_remote_data_source.dart';
import 'package:soul_space/features/articles/domain/entities/article.dart';
import 'package:soul_space/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSourceImpl remoteDataSource;
  final FirebaseFirestore firestore;

  ArticleRepositoryImpl(
    articleRemoteDataSourceImpl, {
    required this.remoteDataSource,
    required this.firestore,
  });

  @override
  Future<Either<Exception, List<Article>>> getArticles() async {
    try {
      final response = await remoteDataSource.fetchArticles();
      return Right(response
          .map((article) => Article(
                id: article.id,
                title: article.title,
                description: article.description,
                url: article.url,
                isFavorite: article.isFavorite,
              ))
          .toList());
    } catch (e) {
      return Left(Exception('Failed to fetch articles'));
    }
  }

  @override
  Future<Either<Exception, void>> addFavorite(String articleId) async {
    try {
      await firestore.collection('favorites').doc(articleId).set({
        'isFavorite': true,
      });
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to add favorite'));
    }
  }

  @override
  Future<Either<Exception, void>> removeFavorite(String articleId) async {
    try {
      await firestore.collection('favorites').doc(articleId).delete();
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to remove favorite'));
    }
  }
}
