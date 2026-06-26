import 'package:orbit/features/auth/domain/entities/app_user.dart';

/// Data collected during onboarding. Role-specific fields are only used for the
/// matching [role]; the data layer maps this to the request body.
class OnboardingInput {
  const OnboardingInput({
    required this.role,
    required this.displayName,
    this.phone,
    this.companyName,
    this.bizNo,
    this.contact,
    this.website,
    this.nickname,
    this.bio,
    this.mainPlatform,
    this.categories = const [],
  });

  final Role role;
  final String displayName;
  final String? phone;

  // company
  final String? companyName;
  final String? bizNo;
  final String? contact;
  final String? website;

  // influencer
  final String? nickname;
  final String? bio;
  final String? mainPlatform;
  final List<String> categories;
}
