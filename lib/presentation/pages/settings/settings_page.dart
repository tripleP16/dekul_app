import 'package:communitary_service_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Settings'),
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: const Text('Log out'))
        ],
      ),
    );
  }
}
