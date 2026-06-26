import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'review_api.g.dart';

@RestApi()
abstract class ReviewApi {
  factory ReviewApi(Dio dio) = _ReviewApi;

  @POST('reviews')
  Future<dynamic> create(@Body() Map<String, dynamic> body);
}
