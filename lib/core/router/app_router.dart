// GoRouter Configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'route_names.dart';
import 'route_paths.dart';
import 'not_found_page.dart';
import '../../shared/widgets/scaffold_with_navbar.dart';
import 'package:provider/provider.dart';
import '../di/injection_container.dart';
import '../../features/absensi/presentation/pages/absensi_page.dart';
import '../../features/absensi/presentation/providers/attendance_provider.dart';

class AppRouter {
  static GoRouter router() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RoutePaths.splash,
      debugLogDiagnostics: true,

      // Redirect logic
      redirect: (context, state) {
        return null;
      },

      routes: [
        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (context, state) => const RegisterPage(),
        ),

        // StatefulShellRoute for Bottom Navigation with persisted state
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavBar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: shellNavigatorKey,
              routes: [
                GoRoute(
                  path: RoutePaths.home,
                  name: RouteNames.home,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.pesan,
                  name: RouteNames.pesan,
                  builder: (context, state) =>
                      const Scaffold(body: Center(child: Text("Pesan"))),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.calendar,
                  name: RouteNames.calendar,
                  builder: (context, state) =>
                      const Scaffold(body: Center(child: Text("Kalender"))),
                ),
              ],
            ),
          ],
        ),

        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: RoutePaths.absensi,
          name: RouteNames.absensi,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => sl<AttendanceProvider>(),
            child: const AbsensiPage(),
          ),
        ),
      ],

      errorBuilder: (context, state) {
        return const NotFoundPage();
      },
    );
  }
}
