import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldwidenews/domain/usecases/get_saved_article.dart';
import 'package:worldwidenews/domain/usecases/remove_article.dart';
import 'package:worldwidenews/domain/usecases/saved_article.dart';
import 'package:worldwidenews/presentation/bloc/article/local/local_article_event.dart';
import 'package:worldwidenews/presentation/bloc/article/local/local_article_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SavedArticleUseCase _savedArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(this._getSavedArticleUseCase, this._savedArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticleLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _savedArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }
}
