import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/tiktok/data/datasources/tiktok_api.dart';
import 'package:orbit/features/tiktok/data/repositories/tiktok_repository_impl.dart';
import 'package:orbit/features/tiktok/domain/entities/tiktok_account.dart';
import 'package:orbit/features/tiktok/domain/repositories/tiktok_repository.dart';

part 'tiktok_providers.g.dart';

@Riverpod(keepAlive: true)
TiktokApi tiktokApi(Ref ref) => TiktokApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
TiktokRepository tiktokRepository(Ref ref) =>
    TiktokRepositoryImpl(ref.watch(tiktokApiProvider));

@riverpod
Future<TiktokAccount?> tiktokAccount(Ref ref) async =>
    unwrap(await ref.watch(tiktokRepositoryProvider).getAccount());
