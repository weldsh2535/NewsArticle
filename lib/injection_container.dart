import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:worldwidenews/data/data_sources/local/app_database.dart';
import 'package:worldwidenews/data/data_sources/remote/news_api_service.dart';
import 'package:worldwidenews/data/repository/article_repository_impl.dart';
import 'package:worldwidenews/domain/repository/article_repository.dart';
import 'package:worldwidenews/domain/usecases/get_article.dart';
import 'package:worldwidenews/domain/usecases/get_saved_article.dart';
import 'package:worldwidenews/domain/usecases/remove_article.dart';
import 'package:worldwidenews/domain/usecases/saved_article.dart';
import 'package:worldwidenews/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'presentation/bloc/article/local/local_article_bloc.dart';

final s1 = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  s1.registerSingleton<AppDatabase>(database);

  //Dio
  s1.registerSingleton<Dio>(Dio());
  //Dependencies
  s1.registerSingleton<NewsApiService>(NewsApiService(s1()));

  s1.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(s1(), s1()));

  //Usecase
  s1.registerSingleton<GetArticleUseCase>(GetArticleUseCase(s1()));

  s1.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(s1()));

  s1.registerSingleton<SavedArticleUseCase>(SavedArticleUseCase(s1()));

  s1.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(s1()));

  //Blocs
  s1.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(s1()));

  s1.registerFactory<LocalArticlesBloc>(
      () => LocalArticlesBloc(s1(), s1(), s1()));
}
