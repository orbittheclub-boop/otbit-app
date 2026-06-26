import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:orbit/core/cache/bookmark_cache.dart';
import 'package:orbit/core/network/network_guard.dart';
import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/campaign/data/datasources/campaign_api.dart';
import 'package:orbit/features/campaign/data/models/campaign_model.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/domain/entities/campaign_input.dart';
import 'package:orbit/features/campaign/domain/repositories/campaign_repository.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  CampaignRepositoryImpl(this._api, this._dio);

  final CampaignApi _api;
  final Dio _dio;

  List<Campaign> _parseList(dynamic res) {
    final list = ((res['data']['campaigns']) as List)
        .cast<Map<String, dynamic>>();
    return list.map((j) => CampaignModel.fromJson(j).toEntity()).toList();
  }

  Campaign _parseOne(dynamic res) => CampaignModel.fromJson(
        res['data']['campaign'] as Map<String, dynamic>,
      ).toEntity();

  @override
  Future<Result<List<Campaign>>> feed({
    String? category,
    String? type,
    String? query,
    String? sort,
  }) =>
      guard(() async {
        // 'popular' is a server-side ranking that ignores the text filters.
        final res = await _api.list(
          sort == 'popular'
              ? {'scope': 'popular'}
              : {
                  'category': ?category,
                  'type': ?type,
                  if (query != null && query.isNotEmpty) 'q': query,
                },
        );
        return _parseList(res);
      });

  @override
  Future<Result<List<Campaign>>> bookmarked() => guard(() async {
        final res = await _api.list({'scope': 'bookmarked'});
        final raw =
            ((res['data']['campaigns']) as List).cast<Map<String, dynamic>>();
        await BookmarkCache.write(raw); // refresh local cache
        return raw.map((j) => CampaignModel.fromJson(j).toEntity()).toList();
      });

  @override
  List<Campaign> cachedBookmarked() => BookmarkCache.read()
      .map((j) => CampaignModel.fromJson(j).toEntity())
      .toList();

  @override
  Future<Result<bool>> toggleBookmark(String id) => guard(() async {
        final res = await _api.bookmark(id);
        return (res['data'] as Map<String, dynamic>)['bookmarked'] as bool;
      });

  @override
  Future<Result<String>> uploadImage({
    required Uint8List bytes,
    required String contentType,
  }) =>
      guard(() async {
        final res = await _dio.post<Map<String, dynamic>>(
          'campaign-image',
          data: Stream<List<int>>.value(bytes),
          options: Options(
            contentType: contentType,
            headers: {Headers.contentLengthHeader: bytes.length},
          ),
        );
        final url = (res.data?['data'] as Map<String, dynamic>?)?['url'];
        if (url is! String) throw const FormatException('no_url');
        return url;
      });

  @override
  Future<Result<List<Campaign>>> myCampaigns({String? status}) => guard(() async {
        final res = await _api.list({
          'scope': 'mine',
          'status': ?status,
        });
        return _parseList(res);
      });

  @override
  Future<Result<Campaign>> detail(String id) =>
      guard(() async => _parseOne(await _api.detail(id)));

  @override
  Future<Result<Campaign>> create(CampaignInput input) =>
      guard(() async => _parseOne(await _api.create(_body(input))));

  @override
  Future<Result<Campaign>> update(String id, CampaignInput input) =>
      guard(() async => _parseOne(await _api.update(id, _body(input))));

  @override
  Future<Result<void>> publish(String id) =>
      guard(() => _api.publish(id));

  @override
  Future<Result<void>> close(String id) => guard(() => _api.close(id));

  @override
  Future<Result<void>> remove(String id) => guard(() => _api.remove(id));

  Map<String, dynamic> _body(CampaignInput i) => {
        'title': i.title,
        'description': i.description,
        'category': i.category,
        'type': i.type.name,
        'reward_type': i.rewardType,
        'reward_amount': i.rewardAmount,
        'recruit_count': i.recruitCount,
        'content_guide': i.contentGuide,
        'min_followers': i.minFollowers,
        'apply_deadline': i.applyDeadline?.toIso8601String(),
        'thumbnail_url': i.thumbnailUrl,
        if (i.publishNow) 'status': 'open',
      };
}
