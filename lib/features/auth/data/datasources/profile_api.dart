import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

/// Retrofit client for the `profile` Edge Function. Each method maps 1:1 to a
/// route; the JSON envelope ({ data: ... }) is unwrapped by the repository.
@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio) = _ProfileApi;

  // Return `dynamic` so Retrofit returns the raw decoded JSON envelope
  // ({ data: ... }) without attempting to deserialize map values. The
  // repository unwraps and maps it to domain models.
  @GET('profile/me')
  Future<dynamic> getMe();

  @POST('profile/complete')
  Future<dynamic> complete(@Body() Map<String, dynamic> body);

  @PATCH('profile')
  Future<dynamic> update(@Body() Map<String, dynamic> body);
}
