abstract class LoginEvent {
  const LoginEvent();
}

class Login extends LoginEvent {
  final String email;
  final String password;

  const Login({required this.email, required this.password});
}
