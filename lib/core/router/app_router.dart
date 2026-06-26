import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:orbit/features/application/presentation/screens/applicants_screen.dart';
import 'package:orbit/features/application/presentation/screens/my_applications_screen.dart';
import 'package:orbit/features/auth/domain/entities/app_user.dart';
import 'package:orbit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbit/features/auth/presentation/screens/login_screen.dart';
import 'package:orbit/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:orbit/features/auth/presentation/screens/signup_screen.dart';
import 'package:orbit/features/auth/presentation/screens/splash_screen.dart';
import 'package:orbit/features/auth/presentation/screens/welcome_screen.dart';
import 'package:orbit/features/campaign/domain/entities/campaign.dart';
import 'package:orbit/features/board/presentation/screens/board_compose_screen.dart';
import 'package:orbit/features/board/presentation/screens/board_detail_screen.dart';
import 'package:orbit/features/board/presentation/screens/board_list_screen.dart';
import 'package:orbit/features/campaign/presentation/screens/bookmarks_screen.dart';
import 'package:orbit/features/campaign/presentation/screens/campaign_detail_screen.dart';
import 'package:orbit/features/campaign/presentation/screens/campaign_form_screen.dart';
import 'package:orbit/features/campaign/presentation/screens/campaign_wizard_screen.dart';
import 'package:orbit/features/home/presentation/screens/company_home_screen.dart';
import 'package:orbit/features/home/presentation/screens/company_profile_screen.dart';
import 'package:orbit/features/home/presentation/screens/influencer_home_screen.dart';
import 'package:orbit/features/home/presentation/screens/influencer_profile_screen.dart';
import 'package:orbit/features/home/presentation/screens/profile_edit_screen.dart';
import 'package:orbit/features/home/presentation/widgets/role_shells.dart';
import 'package:orbit/features/notification/presentation/screens/notifications_screen.dart';
import 'package:orbit/features/settlement/presentation/screens/my_settlements_screen.dart';
import 'package:orbit/features/tiktok/presentation/screens/tiktok_link_screen.dart';

part 'app_router.g.dart';

const _authPages = {'/welcome', '/login', '/signup'};

/// Root navigator — full-screen routes use this so they cover the bottom nav.
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Router driven by [authControllerProvider]. Each role lands on a bottom-nav
/// shell (StatefulShellRoute keeps each tab's state). Detail/form screens are
/// top-level routes so they cover the bottom navigation.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final loc = state.matchedLocation;

      // Only show the full-screen splash on the very first cold load (no value
      // yet). During reloads (e.g. right after sign-in, invalidateSelf) we keep
      // the user on the current page and let the new value redirect them — no
      // spinner flash in between.
      if (auth.isLoading && !auth.hasValue) {
        return loc == '/splash' ? null : '/splash';
      }

      final user = auth.value;
      if (user == null) return _authPages.contains(loc) ? null : '/welcome';
      if (user.role == null) return loc == '/onboarding' ? null : '/onboarding';

      final home = user.role == Role.company ? '/company' : '/influencer';
      if (_authPages.contains(loc) || loc == '/onboarding' || loc == '/splash') {
        return home;
      }

      // Campaign creation/management is company-only (the backend also enforces
      // requireRole(company)). Block any non-company deep-link into these.
      final companyOnly = loc == '/campaign/new' ||
          (loc.startsWith('/campaign/') &&
              (loc.endsWith('/edit') || loc.endsWith('/applicants')));
      if (companyOnly && user.role != Role.company) return home;

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, _) => const SignupScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),

      // Company: 캠페인 / 알림 / 프로필
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => CompanyShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/company', builder: (_, _) => const CompanyHomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/company/board',
              builder: (_, _) => const BoardListScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/company/notifications',
              builder: (_, _) => const NotificationsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/company/profile',
              builder: (_, _) => const CompanyProfileScreen(),
            ),
          ]),
        ],
      ),

      // Influencer: 둘러보기 / 내 지원 / 정산 / 알림 / 프로필
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => InfluencerShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/influencer',
              builder: (_, _) => const InfluencerHomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/influencer/board',
              builder: (_, _) => const BoardListScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/influencer/applications',
              builder: (_, _) => const MyApplicationsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/influencer/settlements',
              builder: (_, _) => const MySettlementsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/influencer/notifications',
              builder: (_, _) => const NotificationsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/influencer/profile',
              builder: (_, _) => const InfluencerProfileScreen(),
            ),
          ]),
        ],
      ),

      // Full-screen routes (cover the bottom nav)
      GoRoute(
        path: '/campaign/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const CampaignWizardScreen(),
      ),
      GoRoute(
        path: '/campaign/bookmarks',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const BookmarksScreen(),
      ),
      GoRoute(
        path: '/board/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const BoardComposeScreen(),
      ),
      GoRoute(
        path: '/board/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) =>
            BoardDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/campaign/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) =>
            CampaignFormScreen(initial: state.extra as Campaign?),
      ),
      GoRoute(
        path: '/campaign/:id/applicants',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) =>
            ApplicantsScreen(campaignId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/campaign/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) =>
            CampaignDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/tiktok-link',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const TiktokLinkScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const ProfileEditScreen(),
      ),
    ],
  );
}
