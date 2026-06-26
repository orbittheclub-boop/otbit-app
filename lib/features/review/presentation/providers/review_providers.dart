import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/core/providers/app_providers.dart';
import 'package:orbit/features/review/data/datasources/review_api.dart';
import 'package:orbit/features/review/data/repositories/review_repository_impl.dart';
import 'package:orbit/features/review/domain/repositories/review_repository.dart';

part 'review_providers.g.dart';

@Riverpod(keepAlive: true)
ReviewApi reviewApi(Ref ref) => ReviewApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
ReviewRepository reviewRepository(Ref ref) =>
    ReviewRepositoryImpl(ref.watch(reviewApiProvider));
