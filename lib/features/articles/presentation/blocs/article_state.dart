part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Article> articles;

  ArticlesLoaded({required this.articles});

  @override
  List<Object> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;

  ArticleError({required this.message});

  @override
  List<Object> get props => [message];
}
