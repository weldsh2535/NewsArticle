import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:worldwidenews/core/constants/constants.dart';
import 'package:worldwidenews/data/models/article.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
