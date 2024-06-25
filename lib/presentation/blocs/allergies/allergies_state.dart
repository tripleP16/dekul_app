import 'package:equatable/equatable.dart';

import '../../../domain/models/allergies/allergies_model.dart';
import '../../shared/widgets/view_models/custom_chip_view_model.dart';

class AllergiesState extends Equatable {
  final List<AllergiesModel> allergies;
  final bool isLoading;

  const AllergiesState({required this.allergies, required this.isLoading});

  @override
  List<Object?> get props => [allergies];

  factory AllergiesState.initial() =>
      const AllergiesState(allergies: [], isLoading: false);

  AllergiesState copyWith({List<AllergiesModel>? allergies, bool? isLoading}) {
    return AllergiesState(
        allergies: allergies ?? this.allergies,
        isLoading: isLoading ?? this.isLoading);
  }

  List<CustomChipViewModel> getCustomChipViewModels() {
    return allergies
        .map((allergy) => CustomChipViewModel(
              label: allergy.name,
              value: allergy.id,
            ))
        .toList();
  }
}
