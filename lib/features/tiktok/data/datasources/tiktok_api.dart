import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'tiktok_api.g.dart';

@RestApi()
abstract class TiktokApi {
  factory TiktokApi(Dio dio) = _TiktokApi;

  @GET('tiktok')
  Future<dynamic> getAccount();

  @GET('tiktok/authorize-url')
  Future<dynamic> authorizeUrl();

  @POST('tiktok/callback')
  Future<dynamic> callback(@Body() Map<String, dynamic> body);

  @POST('tiktok/refresh-stats')
  Future<dynamic> refreshStats();

  @DELETE('tiktok')
  Future<dynamic> unlink();
}
