part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool isPrivacyPolicyChecked;
  final String gender;
  final String birth;
  const SignupState(
      {this.isPrivacyPolicyChecked = false,
      this.gender = 'Other',
      this.birth = ''});

  @override
  List<Object> get props => [isPrivacyPolicyChecked, gender, birth];
  SignupState copyWith({
    bool? isPrivacyPolicyChecked,
    String? gender,
    String? birth,
  }) {
    return SignupState(
      isPrivacyPolicyChecked:
          isPrivacyPolicyChecked ?? this.isPrivacyPolicyChecked,
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
    );
  }
}
