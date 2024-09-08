import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/privileges/privileges_repository.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/user_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/privileges/privileges_cubit.dart';
import 'package:communitary_service_app/presentation/screens/create_user/widgets/user_form_body.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  final String? id;
  static const String routeName = 'create_user';

  const UserScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: id == null ? 'Create User' : 'Edit User'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) {
              final bloc = UserBloc(getIt<UsersRepository>());
              if (id != null) {
                bloc.onStartEditing(id!);
              }
              return bloc;
            },
          ),
          BlocProvider<PrivilegesCubit>(
            create: (context) => PrivilegesCubit(
              getIt<PrivilegesRepository>(),
            ),
          ),
        ],
        child: const UserFormBody(),
      ),
    );
  }
}
