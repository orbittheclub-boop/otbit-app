// Basic sanity test. Feature tests are added per phase with provider overrides.
import 'package:flutter_test/flutter_test.dart';

import 'package:orbit/features/auth/domain/entities/app_user.dart';

void main() {
  test('AppUser defaults to not onboarded with no role', () {
    const user = AppUser(id: 'u1', email: 'a@b.com');
    expect(user.role, isNull);
    expect(user.onboarded, isFalse);
  });
}
