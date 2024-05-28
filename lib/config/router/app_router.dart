import 'package:communitary_service_app/config/router/guards/auth_guard.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/beneficiaries_screen.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/forgot_password_code.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/forgot_password_email.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:communitary_service_app/presentation/screens/screens.dart';
import 'package:communitary_service_app/presentation/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/splash', routes: [
  GoRoute(
    path: '/',
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/login_form',
    name: LoginFormScreen.routeName,
    builder: (context, state) => const LoginFormScreen(),
  ),
  GoRoute(
    path: '/home',
    redirect: authGuard,
    name: BeneficiariesScreen.routeName,
    builder: (context, state) => const BeneficiariesScreen(),
  ),
  GoRoute(
    path: '/splash',
    name: SplashScreen.routeName,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/forgot_password/email',
    name: ForgotPasswordEmail.routeName,
    builder: (context, state) => const ForgotPasswordEmail(),
  ),
  GoRoute(
    path: '/forgot_password/code',
    name: RecoverPasswordCodeScreen.routeName,
    builder: (context, state) => const RecoverPasswordCodeScreen(),
  ),
  GoRoute(
    path: '/restore_password',
    name: ForgotPasswordScreen.routeName,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
]);
