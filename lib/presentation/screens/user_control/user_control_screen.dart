import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/permissions_service.dart';
import 'package:communitary_service_app/config/services/models/permissions_enum.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/presentation/blocs/users/users_list/users_list_bloc.dart';
import 'package:communitary_service_app/presentation/screens/user_control/widgets/search_bar_without_sliver.dart';
import 'package:communitary_service_app/presentation/screens/user_control/widgets/user_list.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserControlScreen extends StatelessWidget {
  static const String routeName = 'user_control';
  const UserControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersListBloc(
        getIt<UsersRepository>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Control de usuarios'),
        body: const _Body(),
        floatingActionButton: FutureBuilder(
            future: getIt<PermissionsService>()
                .hasAccess(PermissionsEnum.createUser),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox.shrink();
              if (snapshot.data == false) return const SizedBox.shrink();
              return FloatingActionButton(
                  onPressed: () {
                    context.push('/create_user');
                  },
                  child: const Icon(Icons.add));
            }),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SizedBox(
          height: size.height * 0.8,
          child: Column(
            children: [
              SearchBarWithoutSliver(
                labelText: 'Buscar usuarios',
                onChanged: (value) =>
                    context.read<UsersListBloc>().search(value),
              ),
              VerticalSpacer.v10().createSpace(),
              const UserList()
            ],
          ),
        ),
      ),
    );
  }
}
