import 'dart:io';

import 'package:dio/dio.dart';
import 'package:worldwidenews/core/constants/constants.dart';
import 'package:worldwidenews/core/resources/data_states.dart';
import 'package:worldwidenews/data/data_sources/local/app_database.dart';
import 'package:worldwidenews/data/models/article.dart';
import 'package:worldwidenews/domain/entities/article.dart';
import 'package:worldwidenews/domain/repository/article_repository.dart';

import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticle() async {
    try {
      final httpResponse = await _newsApiService.getNewArticles(
          apiKey: newsAPIKey, country: countryQuery, category: categoryQuery);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
