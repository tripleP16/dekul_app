import 'package:communitary_service_app/presentation/blocs/users/users_list/users_list_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/users/users_list/users_list_state.dart';
import 'package:communitary_service_app/presentation/screens/user_control/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatefulWidget {
  const UserList({
    super.key,
  });

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<UsersListBloc>().loadNextPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<UsersListBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        if (state.errorMessage != null) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final user = state.totalUsers[index];
              return UserCard(
                user: user,
              );
            },
            itemCount: state.totalUsers.length,
          ),
        );
      },
    );
  }
}
