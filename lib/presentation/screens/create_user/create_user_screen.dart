import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/privileges/privileges_repository.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/create_user_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/privileges/privileges_cubit.dart';
import 'package:communitary_service_app/presentation/screens/create_user/widgets/create_user_form_body.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserScreen extends StatelessWidget {
  final String? id;
  static const String routeName = 'create_user';
  const CreateUserScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Crear usuario'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CreateUserBloc>(
            create: (context) => CreateUserBloc(
              getIt<UsersRepository>(),
            ),
          ),
          BlocProvider<PrivilegesCubit>(
            create: (context) => PrivilegesCubit(
              getIt<PrivilegesRepository>(),
            ),
          ),
        ],
        child: const CreateUserFormBody(),
      ),
    );
  }
}
