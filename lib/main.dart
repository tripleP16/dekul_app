import 'package:communitary_service_app/config/helpers/interceptors/refresh_token_interceptor.dart';
import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
