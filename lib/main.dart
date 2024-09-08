import 'package:communitary_service_app/config/helpers/interceptors/refresh_token_interceptor.dart';
import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/domain/repositories/forgot_password/forgot_password_repository.dart';
import 'package:communitary_service_app/domain/repositories/reports/reports_repository.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/allergies_cubit.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_parent/form_parent_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/medical_history_form/medical_history_form_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/create_code_bloc/create_code_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/restore_password/reset_password_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/validate_code_bloc/validate_code_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/shared/blocs/bottom_navigation_cubit/bottom_navigation_bar_cubit.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'presentation/blocs/auth/auth_state.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
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
      create: (context) => AuthBloc(
        getIt<AuthRepository>(),
      ),
    ),
    BlocProvider(
      create: (_) => ReportsBloc(
        getIt<ReportsRepository>(),
        getIt<BeneficiariesRepository>(),
      ),
    ),
    BlocProvider(
      create: (_) => BottomNavigationBarCubit(),
    ),
    BlocProvider(
      create: (_) => FormBeneficiaryBloc(),
    ),
    BlocProvider(
      create: (_) => FormParentBloc(),
    ),
    BlocProvider(
        create: (_) => AllergiesCubit(
              getIt<AllergiesRepository>(),
            )),
    BlocProvider(
      create: (_) => MedicalHistoryFormBloc(),
    ),
    BlocProvider(
      create: (context) => CreateCodeBloc(
        getIt<ForgotPasswordRepository>(),
      ),
    ),
    BlocProvider(
      create: (context) => ResetPasswordBloc(
        getIt<ForgotPasswordRepository>(),
      ),
    ),
    BlocProvider(
      create: (context) => ValidateCodeBloc(
        getIt<ForgotPasswordRepository>(),
        context.read<ResetPasswordBloc>(),
      ),
    ),
    BlocProvider(create: (context) {
      final beneficiary = context.read<FormBeneficiaryBloc>();
      final parent = context.read<FormParentBloc>();
      final medicalHistory = context.read<MedicalHistoryFormBloc>();
      final beneficiariesRepository = getIt<BeneficiariesRepository>();
      return RegisterBeneficiaryBloc(
        beneficiary,
        parent,
        medicalHistory,
        beneficiariesRepository,
      );
    })
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
