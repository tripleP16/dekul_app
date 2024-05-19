import 'package:communitary_service_app/presentation/screens/beneficiaries/beneficiaries_screen.dart';
import 'package:communitary_service_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
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
    name: BeneficiariesScreen.routeName,
    builder: (context, state) => const BeneficiariesScreen(),
  )
]);
