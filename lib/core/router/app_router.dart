// GoRouter Configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

// Temporary placeholder pages - will be replaced with actual feature pages
class SplashPagePlaceholder extends StatelessWidget {
  const SplashPagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class HomePagePlaceholder extends StatelessWidget {
  const HomePagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home Page - To be implemented')),
    );
  }
}

class AppRouter {
  // This will be updated to accept AuthProvider when authentication is implemented
  static GoRouter router() {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      debugLogDiagnostics: true,
      
      // Redirect logic - will be enhanced with auth guards
      redirect: (context, state) {
        // TODO: Add authentication check
        // final isAuthenticated = authProvider.isAuthenticated;
        // final isLoggingIn = state.matchedLocation == RoutePaths.login;
        
        // if (!isAuthenticated && !isLoggingIn) {
        //   return RoutePaths.login;
        // }
        
        // if (isAuthenticated && isLoggingIn) {
        //   return RoutePaths.home;
        // }
        
        return null; // No redirect
      },
      
      routes: [
        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (context, state) => const SplashPagePlaceholder(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          builder: (context, state) => const HomePagePlaceholder(),
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
