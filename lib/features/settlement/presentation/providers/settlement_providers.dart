import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/settlement/data/datasources/settlement_api.dart';
import 'package:orbit/features/settlement/data/repositories/settlement_repository_impl.dart';
import 'package:orbit/features/settlement/domain/entities/settlement.dart';
import 'package:orbit/features/settlement/domain/repositories/settlement_repository.dart';

part 'settlement_providers.g.dart';

@Riverpod(keepAlive: true)
SettlementApi settlementApi(Ref ref) => SettlementApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
SettlementRepository settlementRepository(Ref ref) =>
    SettlementRepositoryImpl(ref.watch(settlementApiProvider));

@riverpod
Future<List<Settlement>> mySettlements(Ref ref) async =>
    unwrap(await ref.watch(settlementRepositoryProvider).mine());
