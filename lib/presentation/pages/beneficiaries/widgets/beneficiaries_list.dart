import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/presentation/pages/beneficiaries/widgets/beneficiaries_card.dart';
import 'package:flutter/material.dart';

class BeneficiariesList extends StatelessWidget {
  final List<BeneficiaryModel> beneficiaries;
  final bool isLoading;

  const BeneficiariesList({
    Key? key,
    required this.beneficiaries,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading && beneficiaries.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (beneficiaries.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No hay beneficiarios registrados'),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == beneficiaries.length) {
            return isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : null;
          }
          final beneficiary = beneficiaries[index];
          return BeneficiariesCard(
            beneficiary: beneficiary,
          );
        },
        childCount: beneficiaries.length + (isLoading ? 1 : 0),
      ),
    );
  }
}
