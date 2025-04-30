part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchArticlesEvent extends ArticleEvent {}

class ToggleFavoriteEvent extends ArticleEvent {
  final String articleId;

  ToggleFavoriteEvent(this.articleId);

  @override
  List<Object> get props => [articleId];
}
