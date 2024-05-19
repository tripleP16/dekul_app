import 'package:communitary_service_app/config/helpers/interceptors/refresh_token_interceptor.dart';
import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_event.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/blocs/auth/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Locator().init();

  getIt<Dio>()
      .interceptors
      .add(RefreshTokenInterceptor(authRepository: getIt<AuthRepository>()));

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => FormCubit()),
    BlocProvider(
      create: (context) => AuthBloc(getIt<AuthRepository>()),
    )
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<AuthBloc>().add(AppStartedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AppStartedEvent());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          appRouter.go('/');
        }
      },
      child: MaterialApp.router(
        theme: AppTheme().getTheme(),
        routerConfig: appRouter,
      ),
    );
  }
}
