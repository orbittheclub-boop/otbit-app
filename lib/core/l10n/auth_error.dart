import 'package:orbit/core/l10n/l10n.dart';

/// Maps a raw auth/network error (often an English Supabase message) to a
/// message in the user's selected language. Unknown errors fall back to a
/// localized generic message rather than leaking English text.
String localizeAuthError(AppLocalizations l10n, String raw) {
  final m = raw.toLowerCase();

  if (m.contains('invalid login') ||
      m.contains('invalid_credentials') ||
      m.contains('invalid email or password') ||
      m.contains('incorrect')) {
    return l10n.authInvalidCredentials;
  }
  if (m.contains('already registered') ||
      m.contains('already been registered') ||
      m.contains('user already exists') ||
      m.contains('email_exists')) {
    return l10n.authEmailInUse;
  }
  if (m.contains('password should be at least') ||
      m.contains('weak_password') ||
      m.contains('password is too short')) {
    return l10n.passwordMin6;
  }
  if (m.contains('확인 메일') ||
      m.contains('confirm') ||
      m.contains('not confirmed')) {
    return l10n.emailConfirmSent;
  }
  if (m.contains('network') ||
      m.contains('socket') ||
      m.contains('timeout') ||
      m.contains('timed out') ||
      m.contains('connection')) {
    return l10n.authNetwork;
  }
  return l10n.authGeneric;
}
