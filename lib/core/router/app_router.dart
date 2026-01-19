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
import '../../shared/widgets/scaffold_with_navbar.dart';

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
                  builder: (context, state) => const Scaffold(body: Center(child: Text("Pesan"))),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: RoutePaths.calendar, 
                  name: RouteNames.calendar,
                  builder: (context, state) => const Scaffold(body: Center(child: Text("Kalender"))),
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
      ],
      
      errorBuilder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Page not found: ${state.matchedLocation}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go(RoutePaths.splash),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
