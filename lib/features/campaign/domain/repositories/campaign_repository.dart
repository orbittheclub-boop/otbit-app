import 'dart:typed_data';

import 'package:orbit/core/usecase/usecase.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/campaign/domain/entities/campaign_input.dart';

abstract interface class CampaignRepository {
  /// Public feed of `open` campaigns (influencer side). [sort] == 'popular'
  /// returns the applicant-count ranking (ignores text filters).
  Future<Result<List<Campaign>>> feed({
    String? category,
    String? type,
    String? query,
    String? sort,
  });

  /// The calling company's own campaigns, any status.
  Future<Result<List<Campaign>>> myCampaigns({String? status});

  /// Campaigns the caller has bookmarked (찜).
  Future<Result<List<Campaign>>> bookmarked();

  Future<Result<Campaign>> detail(String id);
  Future<Result<Campaign>> create(CampaignInput input);
  Future<Result<Campaign>> update(String id, CampaignInput input);
  Future<Result<void>> publish(String id);
  Future<Result<void>> close(String id);
  Future<Result<void>> remove(String id);

  /// Toggles the bookmark for [id]; returns the new bookmarked state.
  Future<Result<bool>> toggleBookmark(String id);

  /// Uploads a campaign thumbnail image (raw bytes → WebP via Edge Function).
  /// Returns the public URL.
  Future<Result<String>> uploadImage({
    required Uint8List bytes,
    required String contentType,
  });
}
