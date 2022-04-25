import 'package:lemon_tree/core/result/result.dart';
import 'package:logger/logger.dart';

/// 유스케이스 단에서 에러 핸들링 메서드
class ErrorApi {
  static Future<Result<T>> handleError<T>(
      Future<Result<T>> Function() requestFunction, String prefix,
      {Logger? logger}) async {
    logger = Logger();
    try {
      return await requestFunction();
    } on Exception catch (e) {
      logger.e('${e.runtimeType}: 에러 발생', e);
      return Result.error(e.toString());
    } catch (e) {
      logger.e('$prefix : ${e.runtimeType}: 에러 발생, $e', e);
      return Result.error('Auth 에러 발생');
    }
  }
}
