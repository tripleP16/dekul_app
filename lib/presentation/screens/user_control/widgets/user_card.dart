import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/permissions_service.dart';
import 'package:communitary_service_app/config/services/models/permissions_enum.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/domain/models/users/users_model.dart';
import 'package:communitary_service_app/presentation/blocs/users/users_list/users_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserCard extends StatelessWidget {
  final UsersModel user;
  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            getIt<PermissionsService>().hasAccess(PermissionsEnum.deleteUser),
        builder: (context, snapshot) {
          final canDelete = snapshot.data ?? false;
          return Dismissible(
            onDismissed: (direction) {
              context.read<UsersListBloc>().deleteUser(user.id);
            },
            direction:
                canDelete ? DismissDirection.endToStart : DismissDirection.none,
            key: const Key('user_card'),
            background: Container(
              color: AppColors.alertColor,
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  color: AppColors.lightColor,
                ),
              ),
            ),
            child: Card(
              margin: const EdgeInsets.only(bottom: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: ListTile(
                onTap: () {
                  context.push('/user/${user.id}');
                },
                title: Text(user.fullName),
                trailing: FutureBuilder(
                    future: getIt<PermissionsService>()
                        .hasAccess(PermissionsEnum.updateUser),
                    builder: (context, snapshot) {
                      final canUpdate = snapshot.data ?? false;
                      if (!canUpdate) return const SizedBox.shrink();
                      return IconButton(
                        onPressed: () {
                          context.push('/user/${user.id}');
                        },
                        icon: const Icon(Icons.edit),
                      );
                    }),
              ),
            ),
          );
        });
  }
}
