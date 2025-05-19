import 'package:flutter/material.dart';
import '../../features/tabs-layout/presentation/pages/tabs_layout.dart';

class AppRouter {
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/home');
    final pathSegments = uri.pathSegments;

    if (pathSegments.isEmpty || pathSegments.first == 'home') {
      /* SlotCategory category = SlotCategory.instructor;
      if (pathSegments.length > 1) {
        switch (pathSegments[1]) {
          case 'instructor':
            category = SlotCategory.instructor;
            break;
          case 'trainee':
            category = SlotCategory.trainee;
            break;
          case 'observer':
            category = SlotCategory.observer;
            break;
          case 'administration':
            category = SlotCategory.administration;
            break;
        }
      } */
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => TabsLayout(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      );
    }

    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
          ),
      settings: settings,
    );
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
