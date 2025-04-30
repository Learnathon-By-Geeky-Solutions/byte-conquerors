import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:soul_space/application/app_start/bloc/app_start_bloc.dart';
import 'package:soul_space/application/app_view.dart';
import 'package:soul_space/application/navigation/bloc/navigation_bloc.dart';
import 'package:soul_space/features/articles/data/datasources/article_remote_data_source.dart';
import 'package:soul_space/features/articles/data/repositories/article_repository_impl.dart';
import 'package:soul_space/features/articles/domain/usecases/get_articles.dart';
import 'package:soul_space/features/articles/presentation/blocs/article_bloc.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:soul_space/features/gemini_prompts/data/repositories/gemini_repository.dart';
import 'package:soul_space/features/gemini_prompts/presentation/bloc/gemini_bloc.dart';
import 'package:soul_space/features/phq9_assessment/presentation/bloc/phq9_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final dio = Dio();
    final articleRemoteDataSource = ArticleRemoteDataSourceImpl(dio);

    final articleRepository = ArticleRepositoryImpl(
      articleRemoteDataSource,
      firestore: firestore,
      remoteDataSource: articleRemoteDataSource,
    );

    // final userProfileRepository = UserProfileRepositoryImpl(
    //   UserProfileRemoteDataSourceImpl(FirebaseFirestore.instance),
    // );
    // final authRepository = AuthServiceRepository(
    //   authRemoteDataSource: AuthRemoteDataSourceImpl(FirebaseFirestore.instance),
    //   userProfileRepository: userProfileRepository,
    // );

    dotenv.load(fileName: ".env");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Phq9Bloc(),
        ),
        BlocProvider(
          create: (context) =>
              ArticleBloc(GetArticles(articleRepository), articleRepository)
                ..add(FetchArticlesEvent()),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
            create: (context) =>
                SignUpBloc(authRepository: AuthServiceRepository())),
        BlocProvider(create: (_) => AppStartBloc()..add(CheckAppStart())),
        BlocProvider(
          create: (context) {
            final apiKey = dotenv.env['AI_API_KEY']!;
            final model =
                GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
            final repo = GeminiRepository(model);
            return GeminiBloc(repo);
          },
        ),
      ],
      child: const SoulSpaceApp(),
    );
  }
}
