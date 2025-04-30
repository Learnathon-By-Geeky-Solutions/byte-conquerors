import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/articles/domain/entities/article.dart';
import 'package:soul_space/features/articles/domain/repositories/article_repository.dart';
import 'package:soul_space/features/articles/domain/usecases/get_articles.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;
  final ArticleRepository articleRepository;

  ArticleBloc(this.getArticles, this.articleRepository)
      : super(ArticleInitial());

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield ArticleLoading();
      final failureOrArticles = await getArticles();
      yield failureOrArticles.fold(
        (failure) => ArticleError(message: 'Failed to load articles'),
        (articles) => ArticlesLoaded(articles: articles),
      );
    } else if (event is ToggleFavoriteEvent && state is ArticlesLoaded) {
      final currentState = state as ArticlesLoaded;
      final updatedArticles = List<Article>.from(currentState.articles);

      final index = updatedArticles.indexWhere((a) => a.id == event.articleId);
      if (index == -1) {
        return; // If no article found with the given ID, do nothing.
      }

      final article = updatedArticles[index];
      final isNowFavorite = !article.isFavorite;

      try {
        if (isNowFavorite) {
          await articleRepository
              .addFavorite(article.id); // Assume this adds to Firestore
        } else {
          await articleRepository
              .removeFavorite(article.id); // Assume this removes from Firestore
        }

        // Update the article's favorite status
        updatedArticles[index] = article.copyWith(isFavorite: isNowFavorite);

        // Emit the updated list of articles
        yield ArticlesLoaded(articles: updatedArticles);
      } catch (e) {
        yield ArticleError(message: 'Failed to update favorite status');
      }
    }
  }
}
