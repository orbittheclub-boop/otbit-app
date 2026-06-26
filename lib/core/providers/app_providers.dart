import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:orbit/core/network/dio_client.dart';

part 'app_providers.g.dart';

/// Root of the Riverpod DI graph (code-generated). Everything is wired through
/// providers — no get_it, no singletons.

@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => DioClient.create(ref.watch(supabaseClientProvider));
