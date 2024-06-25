enum RegisterBeneficiaryStatus {
  loading,
  success,
  error,
  initial,
}

class RegisterBeneficiaryState {
  final RegisterBeneficiaryStatus status;

  RegisterBeneficiaryState({required this.status});

  RegisterBeneficiaryState copyWith({
    RegisterBeneficiaryStatus? status,
  }) {
    return RegisterBeneficiaryState(
      status: status ?? this.status,
    );
  }

  factory RegisterBeneficiaryState.initial() {
    return RegisterBeneficiaryState(status: RegisterBeneficiaryStatus.initial);
  }
}
