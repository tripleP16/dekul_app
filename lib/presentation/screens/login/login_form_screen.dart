import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/login/login_repository.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/login/login_bloc.dart';
import 'package:communitary_service_app/presentation/screens/login/widgets/form_body_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormScreen extends StatelessWidget {
  static const routeName = 'login_form';
  const LoginFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Inicio de sesión',
      ),
      body: BlocProvider(
          create: (context) =>
              LoginBloc(getIt<LoginRepository>(), context.read<AuthBloc>()),
          child: _FormBody()),
    );
  }
}

class _FormBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 90),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 45),
          child: FormComponents(),
        ),
      ),
    );
  }
}
