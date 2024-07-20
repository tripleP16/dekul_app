enum PermissionsEnum {
  createUser('CREATE_USER'),
  updateUser('UPDATE_USER'),
  deleteUser('DELETE_USER'),
  createBeneficiary('CREATE_BENEFICIARY'),
  updateBeneficiary('UPDATE_BENEFICIARY'),
  deleteBeneficiary('DELETE_BENEFICIARY'),
  createAllergy('CREATE_ALERGIE');

  final String value;

  const PermissionsEnum(this.value);
}
