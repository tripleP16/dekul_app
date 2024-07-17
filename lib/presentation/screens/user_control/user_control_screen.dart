import 'package:communitary_service_app/presentation/screens/user_control/widgets/search_bar_without_sliver.dart';
import 'package:communitary_service_app/presentation/screens/user_control/widgets/user_list.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserControlScreen extends StatelessWidget {
  static const String routeName = 'user_control';
  const UserControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Control de usuarios'),
      body: const _Body(),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
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
                onChanged: (value) => print('Search: $value'),
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
