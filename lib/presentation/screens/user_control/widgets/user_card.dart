import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
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
          title: const Text('Usuario '),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
