import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'campaign_api.g.dart';

/// Retrofit client for the `campaigns` Edge Function. Returns `dynamic` so the
/// raw `{ data: ... }` envelope is handed to the repository to unwrap.
@RestApi()
abstract class CampaignApi {
  factory CampaignApi(Dio dio) = _CampaignApi;

  @GET('campaigns')
  Future<dynamic> list(@Queries() Map<String, dynamic> query);

  @GET('campaigns/{id}')
  Future<dynamic> detail(@Path('id') String id);

  @POST('campaigns')
  Future<dynamic> create(@Body() Map<String, dynamic> body);

  @PATCH('campaigns/{id}')
  Future<dynamic> update(@Path('id') String id, @Body() Map<String, dynamic> body);

  @DELETE('campaigns/{id}')
  Future<dynamic> remove(@Path('id') String id);

  @POST('campaigns/{id}/bookmark')
  Future<dynamic> bookmark(@Path('id') String id);

  @POST('campaigns/{id}/publish')
  Future<dynamic> publish(@Path('id') String id);

  @POST('campaigns/{id}/close')
  Future<dynamic> close(@Path('id') String id);
}
