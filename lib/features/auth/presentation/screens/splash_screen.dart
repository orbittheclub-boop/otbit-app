import 'package:flutter/material.dart';

/// Shown only during the first cold load (while the session/profile resolves).
/// Intentionally blank (just the theme background) — no logo, no spinner — so
/// the app reads as going straight in rather than through an interstitial.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold();
}
