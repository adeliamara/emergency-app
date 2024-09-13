import 'package:go_router/go_router.dart';

import '../modules/auth/pages/login_page.dart';
import '../modules/auth/pages/recovery_password_page.dart';
import '../modules/auth/pages/register_page.dart';
import '../modules/call/call_page.dart';
import '../modules/emergency_button/home_page.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/home',
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
          path: 'home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: 'call',
          builder: (context, state) => CallPage(),
        )
      ],
    ),
  ],
);
