import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/bootstrap/bootstrap.dart';
import '../features/auth/application/auth_controller.dart';
import '../features/auth/presentation/onboarding_page.dart';
import '../features/auth/presentation/pin_login_page.dart';
import '../features/auth/presentation/splash_page.dart';
import '../features/customers/presentation/customers_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/debts/presentation/debts_page.dart';
import '../features/products/presentation/products_page.dart';
import '../features/reports/presentation/reports_page.dart';
import '../features/sales/presentation/sales_page.dart';
import '../features/settings/presentation/settings_page.dart';
import 'home_shell.dart';

enum AppRoute {
  splash('/splash'),
  onboarding('/onboarding'),
  pin('/pin'),
  dashboard('/dashboard'),
  sales('/sales'),
  products('/products'),
  customers('/customers'),
  debts('/debts'),
  reports('/reports'),
  settings('/settings');

  const AppRoute(this.path);

  final String path;
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final bootstrapState = ref.watch(appBootstrapProvider);

  return GoRouter(
    debugLogDiagnostics: false,
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoute.pin.path,
        name: AppRoute.pin.name,
        builder: (context, state) => const PinLoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShellPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.dashboard.path,
              name: AppRoute.dashboard.name,
              builder: (context, state) => const DashboardPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.sales.path,
              name: AppRoute.sales.name,
              builder: (context, state) => const SalesPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.products.path,
              name: AppRoute.products.name,
              builder: (context, state) => const ProductsPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.customers.path,
              name: AppRoute.customers.name,
              builder: (context, state) => const CustomersPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.debts.path,
              name: AppRoute.debts.name,
              builder: (context, state) => const DebtsPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.reports.path,
              name: AppRoute.reports.name,
              builder: (context, state) => const ReportsPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoute.settings.path,
              name: AppRoute.settings.name,
              builder: (context, state) => const SettingsPage(),
            ),
          ]),
        ],
      ),
    ],
    redirect: (context, state) {
      final location = state.uri.path;

      if (bootstrapState.isLoading) {
        return location == AppRoute.splash.path ? null : AppRoute.splash.path;
      }

      if (authState.status == AuthStatus.unknown) {
        return AppRoute.splash.path;
      }

      if (authState.status == AuthStatus.onboardingRequired &&
          location != AppRoute.onboarding.path) {
        return AppRoute.onboarding.path;
      }

      if (authState.status == AuthStatus.unauthenticated &&
          location != AppRoute.pin.path) {
        return AppRoute.pin.path;
      }

      final isAuthPage =
          location == AppRoute.pin.path || location == AppRoute.onboarding.path;
      if (authState.status == AuthStatus.authenticated && isAuthPage) {
        return AppRoute.dashboard.path;
      }

      if (location == AppRoute.splash.path &&
          authState.status == AuthStatus.authenticated) {
        return AppRoute.dashboard.path;
      }

      return null;
    },
  );
});
