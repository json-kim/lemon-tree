import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginWithEmail(String email, String password) =
      LoginWithEmail;
  const factory AuthEvent.signUp(String email, String password, String name) =
      SignUp;
  const factory AuthEvent.logOut() = LogOut;
}
