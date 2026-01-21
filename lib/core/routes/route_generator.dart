import 'package:flutter/material.dart';

import '../../presentation/screens/test_firebase_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Authentication Routes
      case AppRoutes.splash:
        return _buildRoute(
          const SplashScreen(),
          settings,
        );

      case AppRoutes.login:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Login Page'))),
          settings,
        );

      case AppRoutes.register:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Register Page'))),
          settings,
        );

      case AppRoutes.forgotPassword:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Forgot Password Page'))),
          settings,
        );

      case AppRoutes.resetPassword:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Reset Password Page'))),
          settings,
        );

      case AppRoutes.verifyEmail:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Verify Email Page'))),
          settings,
        );

      // Main Routes
      case AppRoutes.home:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Home')),
            body: const Center(child: Text('Home Page')),
          ),
          settings,
        );

      case AppRoutes.dashboard:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Dashboard')),
            body: const Center(child: Text('Dashboard Page')),
          ),
          settings,
        );

      case AppRoutes.profile:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(child: Text('Profile Page')),
          ),
          settings,
        );

      case AppRoutes.settings:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: const Center(child: Text('Settings Page')),
          ),
          settings,
        );

      case AppRoutes.editProfile:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Edit Profile')),
            body: const Center(child: Text('Edit Profile Page')),
          ),
          settings,
        );

      // Feature Routes
      case AppRoutes.itemList:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Items')),
            body: const Center(child: Text('Item List Page')),
          ),
          settings,
        );

      case AppRoutes.itemCreate:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Create Item')),
            body: const Center(child: Text('Create Item Page')),
          ),
          settings,
        );

      // Additional Routes
      case AppRoutes.notifications:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Notifications')),
            body: const Center(child: Text('Notifications Page')),
          ),
          settings,
        );

      case AppRoutes.search:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Search')),
            body: const Center(child: Text('Search Page')),
          ),
          settings,
        );

      case AppRoutes.about:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('About')),
            body: const Center(child: Text('About Page')),
          ),
          settings,
        );

      case AppRoutes.help:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Help')),
            body: const Center(child: Text('Help Page')),
          ),
          settings,
        );

      case AppRoutes.testFirebase:
        return _buildRoute(
          const TestFirebaseScreen(),
          settings,
        );

      case AppRoutes.termsAndConditions:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Terms & Conditions')),
            body: const Center(child: Text('Terms & Conditions Page')),
          ),
          settings,
        );

      case AppRoutes.privacyPolicy:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('Privacy Policy')),
            body: const Center(child: Text('Privacy Policy Page')),
          ),
          settings,
        );

      // Error Routes
      case AppRoutes.notFound:
        return _buildRoute(
          _buildErrorPage('Page not found'),
          settings,
        );

      case AppRoutes.error:
        return _buildRoute(
          _buildErrorPage('An error occurred'),
          settings,
        );

      default:
        // Handle dynamic routes (with parameters)
        if (settings.name?.startsWith('/items/') == true) {
          return _handleItemRoutes(settings);
        }

        // Not found route - fallback to AppRoutes.notFound
        return _buildRoute(
          _buildErrorPage('Route not found: ${settings.name}'),
          settings,
        );
    }
  }

  // Handle item-related dynamic routes
  static Route<dynamic> _handleItemRoutes(RouteSettings settings) {
    final uri = Uri.parse(settings.name!);
    final segments = uri.pathSegments;

    if (segments.length == 2 && segments[0] == 'items') {
      // /items/:id
      final id = segments[1];
      return _buildRoute(
        Scaffold(
          appBar: AppBar(title: const Text('Item Detail')),
          body: Center(child: Text('Item Detail Page - ID: $id')),
        ),
        settings,
      );
    } else if (segments.length == 3 &&
        segments[0] == 'items' &&
        segments[2] == 'edit') {
      // /items/:id/edit
      final id = segments[1];
      return _buildRoute(
        Scaffold(
          appBar: AppBar(title: const Text('Edit Item')),
          body: Center(child: Text('Edit Item Page - ID: $id')),
        ),
        settings,
      );
    }

    return _buildRoute(
      _buildErrorPage('Invalid item route: ${settings.name}'),
      settings,
    );
  }

  // Helper method to build routes with transitions
  static MaterialPageRoute _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  // Helper method to build routes with custom transitions
  // ignore: unused_element
  static PageRouteBuilder _buildRouteWithTransition(
    Widget page,
    RouteSettings settings, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: duration,
      settings: settings,
    );
  }

  // Build error page
  static Widget _buildErrorPage(String message) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple splash screen that navigates to our test screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Time Expense Tracker'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Real Time Expense Tracker',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Testing Firebase Integration',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.testFirebase);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Go to Firebase Test Screen',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Go to Login',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
