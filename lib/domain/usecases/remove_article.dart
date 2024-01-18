import 'package:worldwidenews/core/usecases/usecase.dart';
import 'package:worldwidenews/domain/entities/article.dart';
import 'package:worldwidenews/domain/repository/article_repository.dart';

class RemoveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;
  RemoveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.removeArticle(params!);
  }
}
