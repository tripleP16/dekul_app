import 'package:communitary_service_app/config/router/guards/auth_guard.dart';
import 'package:communitary_service_app/presentation/pages/home/home_page.dart';
import 'package:communitary_service_app/presentation/screens/screens.dart';
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
    name: HomePage.routeName,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/splash',
    redirect: splashGuard,
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
  GoRoute(
    path: '/beneficiaries',
    redirect: authGuard,
    routes: [
      GoRoute(
        path: 'create',
        redirect: authGuard,
        name: RegisterBeneficiariesScreen.routeName,
        builder: (context, state) => const RegisterBeneficiariesScreen(),
      ),
      GoRoute(
        path: 'parent',
        redirect: authGuard,
        name: RegisterParentScreen.routeName,
        builder: (context, state) => const RegisterParentScreen(),
      ),
      GoRoute(
        path: 'medical_history',
        redirect: authGuard,
        name: MedicalHistoryScreen.routeName,
        builder: (context, state) => const MedicalHistoryScreen(),
      ),
      GoRoute(
        path: 'details/:id',
        redirect: authGuard,
        name: BeneficiaryDetailsScreen.routeName,
        builder: (context, state) => BeneficiaryDetailsScreen(
          id: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: 'update/medical_history/:id',
        redirect: authGuard,
        name: MedicalHistoryUpdateScreen.routeName,
        builder: (context, state) =>
            MedicalHistoryUpdateScreen(id: state.pathParameters['id'] ?? ''),
      ),
    ],
  ),
  GoRoute(
    path: '/create/alergies',
    redirect: authGuard,
    name: AlergiesScreen.routeName,
    builder: (context, state) => const AlergiesScreen(),
  ),
  GoRoute(
    path: '/user_control',
    redirect: authGuard,
    name: UserControlScreen.routeName,
    builder: (context, state) => const UserControlScreen(),
  ),
  GoRoute(
    path: '/change_password',
    redirect: authGuard,
    name: ChangePasswordScreen.routeName,
    builder: (context, state) => const ChangePasswordScreen(),
  ),
  GoRoute(
    path: '/edit_profile',
    redirect: authGuard,
    name: EditMyProfileScreen.routeName,
    builder: (context, state) => const EditMyProfileScreen(),
  ),
  GoRoute(
    path: '/create_user',
    name: CreateUserScreen.routeName,
    builder: (context, state) => const CreateUserScreen(),
  ),
]);
