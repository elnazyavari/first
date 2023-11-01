abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  String username;
  String password;
  AuthLoginEvent(this.username, this.password);
}

class AuthSignupEvent extends AuthEvent {
  String username;
  String password;
  String confirmPassword;
  AuthSignupEvent(this.username, this.password, this.confirmPassword);
}
