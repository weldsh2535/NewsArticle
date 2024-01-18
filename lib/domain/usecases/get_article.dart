import 'package:worldwidenews/core/resources/data_states.dart';
import 'package:worldwidenews/core/usecases/usecase.dart';
import 'package:worldwidenews/domain/entities/article.dart';
import 'package:worldwidenews/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticle();
  }
}
