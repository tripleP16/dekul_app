import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiaries_list/beneficiaries_list_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiaries_list/beneficiaries_list_state.dart';
import 'package:communitary_service_app/presentation/pages/beneficiaries/widgets/beneficiaries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/widgets.dart';

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BeneficiariesListBloc(
        getIt<BeneficiariesRepository>(),
      ),
      child: const Scaffold(
        body: BeneficiariesBody(),
      ),
    );
  }
}

class BeneficiariesBody extends StatefulWidget {
  const BeneficiariesBody({super.key});

  @override
  State<BeneficiariesBody> createState() => _BeneficiariesBodyState();
}

class _BeneficiariesBodyState extends State<BeneficiariesBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<BeneficiariesListBloc>().loadNextPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<BeneficiariesListBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeneficiariesListBloc, BeneficiariesListState>(
      builder: (context, state) {
        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomSearchBar(
              labelText: 'Buscar beneficiario',
              onChanged: (p0) =>
                  context.read<BeneficiariesListBloc>().search(p0),
            ),
            BeneficiariesList(
              beneficiaries: state.totalBeneficiaries,
              isLoading: state.isLoading,
            ),
          ],
        );
      },
    );
  }
}
