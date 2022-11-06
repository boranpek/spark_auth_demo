part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final bool isButtonActive;
  const ForgotPasswordState({this.isButtonActive = false});

  @override
  List<Object> get props => [isButtonActive];

  ForgotPasswordState copyWith({
    bool? isButtonActive,
  }) {
    return ForgotPasswordState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
    );
  }
}
