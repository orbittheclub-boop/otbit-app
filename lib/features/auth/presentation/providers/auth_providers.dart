import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/features/auth/data/datasources/profile_api.dart';
import 'package:orbit/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:orbit/features/auth/domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
ProfileApi profileApi(Ref ref) => ProfileApi(ref.watch(dioProvider));

/// Auth boundary — impl injected here; swap this one provider for AWS Cognito.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
      ref.watch(supabaseClientProvider),
      ref.watch(profileApiProvider),
      ref.watch(dioProvider),
    );
