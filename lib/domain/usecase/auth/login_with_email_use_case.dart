import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/auth_repository.dart';

class LoginWithEmailUseCase {
  final AuthRepository _authRepository;

  LoginWithEmailUseCase(this._authRepository);

  Future<Result<void>> call(String email, String password) async {
    return ErrorApi.handleError(() async {
      final result = await _authRepository.loginWithEmail(email, password);

      return Result.success(null);
    }, '$runtimeType');
  }
}
