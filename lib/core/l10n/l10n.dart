import 'package:flutter/widgets.dart';

import 'package:orbit/l10n/app_localizations.dart';

export 'package:orbit/l10n/app_localizations.dart';

/// `context.l10n.someKey` shorthand.
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
