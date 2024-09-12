import 'package:emergency_app/modules/call/call_page.dart';
import 'package:emergency_app/modules/call/full_screen_alert.dart';
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
      return MaterialPageRoute(
          builder: (_) => const FullScreenNotificationScreen());

    case '/call':
      return MaterialPageRoute(builder: (_) => const GoogleMapScreen());

    default:
      return MaterialPageRoute(builder: (_) => const LoginPage()); // Fallback
  }
}
