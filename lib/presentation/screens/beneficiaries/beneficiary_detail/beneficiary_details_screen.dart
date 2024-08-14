import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/permissions_service.dart';
import 'package:communitary_service_app/config/services/models/permissions_enum.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiary_detail/beneficiary_detail_cubit.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiary_detail/beneficiary_detail_state.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/beneficiary_detail_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiaryDetailsScreen extends StatelessWidget {
  static const String routeName = 'beneficiary_detail';
  final String id;
  const BeneficiaryDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeneficiaryDetailCubit(
        getIt<BeneficiariesRepository>(),
        id,
      ),
      child: FutureBuilder(
          future: getIt<PermissionsService>()
              .hasAccess(PermissionsEnum.updateBeneficiary),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: CustomAppBar(
                title: 'Beneficiario',
                actions: snapshot.data ?? false
                    ? [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ]
                    : null,
              ),
              body: const _Body(),
            );
          }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeneficiaryDetailCubit, BeneficiaryDetailState>(
      builder: (context, state) {
        if (state.status == BeneficiaryDetailStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == BeneficiaryDetailStatus.error) {
          return Center(
              child: Text(state.errorMessage ??
                  'Error inesperado por favor contactar al administrador.'));
        }

        return BeneficiaryDetail(
          model: state.model!,
        );
      },
    );
  }
}
