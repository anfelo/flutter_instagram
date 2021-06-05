part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final String username;
  final SignupStatus status;
  final Failure failure;

  bool get isFormValid =>
      username.isEmpty && email.isNotEmpty && password.isEmpty;

  const SignupState({
    @required this.email,
    @required this.password,
    @required this.username,
    @required this.status,
    @required this.failure,
  });

  factory SignupState.initial() {
    return SignupState(
      email: '',
      password: '',
      username: '',
      status: SignupStatus.initial,
      failure: const Failure(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, password, username, status, failure];

  SignupState copyWith({
    String email,
    String password,
    String username,
    SignupStatus status,
    Failure failure,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
