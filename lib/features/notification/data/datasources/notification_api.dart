import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio) = _NotificationApi;

  @GET('notifications')
  Future<dynamic> list();

  @POST('notifications/read')
  Future<dynamic> markRead(@Body() Map<String, dynamic> body);

  @POST('notifications/register-device')
  Future<dynamic> registerDevice(@Body() Map<String, dynamic> body);
}
