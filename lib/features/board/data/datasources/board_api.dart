import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'board_api.g.dart';

/// Retrofit client for the `board` Edge Function. Returns `dynamic` so the raw
/// `{ data: ... }` envelope is handed to the repository to unwrap.
@RestApi()
abstract class BoardApi {
  factory BoardApi(Dio dio) = _BoardApi;

  @GET('board')
  Future<dynamic> list(@Query('category') String? category);

  @GET('board/{id}')
  Future<dynamic> detail(@Path('id') String id);

  @POST('board')
  Future<dynamic> create(@Body() Map<String, dynamic> body);

  @PATCH('board/{id}')
  Future<dynamic> update(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('board/{id}')
  Future<dynamic> remove(@Path('id') String id);

  @POST('board/{id}/like')
  Future<dynamic> like(@Path('id') String id);

  @POST('board/{id}/comments')
  Future<dynamic> addComment(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('board/{id}/comments/{cid}')
  Future<dynamic> deleteComment(@Path('id') String id, @Path('cid') String cid);
}
