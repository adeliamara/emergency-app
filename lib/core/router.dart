import 'package:emergency_app/modules/call/full_screen_alert.dart';
import 'package:emergency_app/modules/call/map_page.dart';
import 'package:flutter/material.dart';

import '../modules/auth/pages/login_page.dart';
import '../modules/auth/pages/recovery_password_page.dart';
import '../modules/auth/pages/register_page.dart';
import '../modules/contacts/contacts_page.dart';
import '../modules/emergency_button/emergency_button_page.dart';
import '../modules/profile/profile_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const LoginPage());

    case '/auth':
      return MaterialPageRoute(builder: (_) => const LoginPage());

    case '/auth/register':
      return MaterialPageRoute(builder: (_) => const RegisterPage());

    case '/auth/recovery-password':
      return MaterialPageRoute(builder: (_) => const RecoveryPasswordPage());

    case '/emergency-button':
      return MaterialPageRoute(builder: (_) => const EmergencyButtonPage());

    case '/contacts':
      return MaterialPageRoute(builder: (_) => const ContactsPage());

    case '/profile':
      return MaterialPageRoute(builder: (_) => const ProfilePage());

    case '/notification_alert':
      final args = settings.arguments as Map<String, dynamic>;
      print('args $args');
      return MaterialPageRoute(
          builder: (_) => FullScreenNotificationScreen(
                lat: args['lat'] ?? '10',
                long: args['long'] ?? '10',
                userName: args['userName'] ?? 'User',
              ));

    case '/map':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => GoogleMapScreen(
                lat: args['lat']!,
                long: args['long']!,
                userName: args['userName']!,
              ));

    default:
      return MaterialPageRoute(builder: (_) => const LoginPage()); // Fallback
  }
}
