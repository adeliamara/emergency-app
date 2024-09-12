import 'package:go_router/go_router.dart';

import '../modules/auth/pages/login_page.dart';
import '../modules/auth/pages/recovery_password_page.dart';
import '../modules/auth/pages/register_page.dart';
import '../modules/call/call_page.dart';
import '../modules/contacts/contacts_page.dart';
import '../modules/emergency_button/emergency_button_page.dart';
import '../modules/profile/profile_page.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/auth',
      routes: [
        GoRoute(
          path: 'auth',
          builder: (context, state) => LoginPage(),
          routes: [
            GoRoute(
              path: 'register',
              builder: (context, state) => RegisterPage(),
            ),
            GoRoute(
              path: 'recovery-password',
              builder: (context, state) => RecoveryPasswordPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'emergency-button',
          builder: (context, state) => EmergencyButtonPage(),
        ),
        GoRoute(
          path: 'contacts',
          builder: (context, state) => ContactsPage(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => ProfilePage(),
        ),
        GoRoute(
          path: 'call',
          builder: (context, state) => CallPage(),
        )
      ],
    ),
  ],
);
