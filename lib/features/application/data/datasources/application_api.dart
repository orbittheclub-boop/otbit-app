import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'application_api.g.dart';

@RestApi()
abstract class ApplicationApi {
  factory ApplicationApi(Dio dio) = _ApplicationApi;

  @POST('applications')
  Future<dynamic> apply(@Body() Map<String, dynamic> body);

  @GET('applications')
  Future<dynamic> list(@Queries() Map<String, dynamic> query);

  @POST('applications/{id}/decide')
  Future<dynamic> decide(@Path('id') String id, @Body() Map<String, dynamic> body);

  @POST('applications/{id}/submit')
  Future<dynamic> submit(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('applications/{id}')
  Future<dynamic> cancel(@Path('id') String id);
}
