import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Result<void>> call() async {
    await _authRepository.logOut();

    return const Result.success(null);
  }
}
