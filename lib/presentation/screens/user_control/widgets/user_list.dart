import 'package:communitary_service_app/presentation/screens/user_control/widgets/user_card.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  const UserList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return const UserCard();
        },
        itemCount: 100,
      ),
    );
  }
}
