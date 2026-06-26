import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/application/data/datasources/application_api.dart';
import 'package:orbit/features/application/data/repositories/application_repository_impl.dart';
import 'package:orbit/features/application/domain/entities/application.dart';
import 'package:orbit/features/application/domain/repositories/application_repository.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
ApplicationApi applicationApi(Ref ref) => ApplicationApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
ApplicationRepository applicationRepository(Ref ref) =>
    ApplicationRepositoryImpl(ref.watch(applicationApiProvider));

@riverpod
Future<List<Application>> myApplications(Ref ref) async =>
    unwrap(await ref.watch(applicationRepositoryProvider).myApplications());

@riverpod
Future<List<Application>> applicants(Ref ref, String campaignId) async => unwrap(
      await ref.watch(applicationRepositoryProvider).applicantsOf(campaignId),
    );
