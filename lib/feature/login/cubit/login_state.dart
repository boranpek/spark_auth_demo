part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isPasswordChecked;
  final bool isEmailChecked;
  const LoginState({
    this.isPasswordChecked = false,
    this.isEmailChecked = false,
  });

  @override
  List<Object> get props => [isPasswordChecked, isEmailChecked];

  LoginState copyWith({
    bool? isPasswordChecked,
    bool? isEmailChecked,
  }) {
    return LoginState(
      isPasswordChecked: isPasswordChecked ?? this.isPasswordChecked,
      isEmailChecked: isEmailChecked ?? this.isEmailChecked,
    );
  }
}
