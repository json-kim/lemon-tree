import 'package:lemon_tree/core/error/error_api.dart';
import 'package:lemon_tree/core/result/result.dart';
import 'package:lemon_tree/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Result<void>> call() async {
    return ErrorApi.handleError(() async {
      await _authRepository.logOut();

      return const Result.success(null);
    }, '$runtimeType');
  }
}
