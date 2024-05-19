import 'package:communitary_service_app/config/router/guards/auth_guard.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/beneficiaries_screen.dart';
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
  )
]);
