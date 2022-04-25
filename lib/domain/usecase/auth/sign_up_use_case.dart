import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<Result<void>> call(String email, String password, String name) async {
    return ErrorApi.handleError(() async {
      final result =
          await _authRepository.signUpWithEmail(email, password, name);

      return Result.success(null);
    }, '$runtimeType');
  }
}
