import 'package:worldwidenews/core/resources/data_states.dart';
import 'package:worldwidenews/domain/entities/article.dart';

abstract class ArticleRepository {
  //API methods
  Future<DataState<List<ArticleEntity>>> getNewsArticle();
  //Database methods
  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);
}
