abstract class AuthRepository {
  Future<void> loginWithEmail(String email, String password);

  Future<void> signUpWithEmail(String email, String password, String name);

  Future<void> logOut();
}
