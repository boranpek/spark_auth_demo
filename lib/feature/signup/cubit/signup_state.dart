part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool isPrivacyPolicyChecked;
  const SignupState({this.isPrivacyPolicyChecked = false});

  @override
  List<Object> get props => [isPrivacyPolicyChecked];
  SignupState copyWith({
    bool? isPrivacyPolicyChecked,
  }) {
    return SignupState(
      isPrivacyPolicyChecked:
          isPrivacyPolicyChecked ?? this.isPrivacyPolicyChecked,
    );
  }
}
