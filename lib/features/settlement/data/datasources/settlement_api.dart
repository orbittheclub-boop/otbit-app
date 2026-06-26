import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'settlement_api.g.dart';

@RestApi()
abstract class SettlementApi {
  factory SettlementApi(Dio dio) = _SettlementApi;

  @POST('settlements')
  Future<dynamic> create(@Body() Map<String, dynamic> body);

  @PATCH('settlements/{id}')
  Future<dynamic> updateStatus(
      @Path('id') String id, @Body() Map<String, dynamic> body);

  @GET('settlements')
  Future<dynamic> list(@Queries() Map<String, dynamic> query);
}
