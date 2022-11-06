part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool isPrivacyPolicyChecked;
  final String gender;
  final String birth;
  final bool isPasswordChecked;
  final bool isConfirmPasswordChecked;
  final bool isEmailChecked;
  final bool isNameChecked;
  const SignupState({
    this.isPrivacyPolicyChecked = false,
    this.gender = 'Other',
    this.birth = '',
    this.isConfirmPasswordChecked = false,
    this.isEmailChecked = false,
    this.isNameChecked = false,
    this.isPasswordChecked = false,
  });

  @override
  List<Object> get props => [
        isPrivacyPolicyChecked,
        gender,
        birth,
        isConfirmPasswordChecked,
        isPasswordChecked,
        isEmailChecked,
        isNameChecked
      ];
  SignupState copyWith({
    bool? isPrivacyPolicyChecked,
    String? gender,
    String? birth,
    bool? isConfirmPasswordChecked,
    bool? isPasswordChecked,
    bool? isEmailChecked,
    bool? isNameChecked,
  }) {
    return SignupState(
      isPrivacyPolicyChecked:
          isPrivacyPolicyChecked ?? this.isPrivacyPolicyChecked,
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
      isConfirmPasswordChecked: isConfirmPasswordChecked ?? this.isConfirmPasswordChecked,
      isEmailChecked: isEmailChecked ?? this.isEmailChecked,
      isPasswordChecked: isPasswordChecked ?? this.isPasswordChecked,
      isNameChecked: isNameChecked ?? this.isNameChecked,
    );
  }
}
