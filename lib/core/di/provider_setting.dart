import 'package:lemon_tree/data/data_source/local/token_local_data_source.dart';
import 'package:lemon_tree/data/data_source/remote/auth_api.dart';
import 'package:lemon_tree/data/data_source/remote/token_api.dart';
import 'package:lemon_tree/data/repository/auth_repository_impl.dart';
import 'package:lemon_tree/data/repository/tree_repository_impl.dart';
import 'package:lemon_tree/domain/repository/tree_repository.dart';
import 'package:lemon_tree/domain/usecase/auth/login_with_email_use_case.dart';
import 'package:lemon_tree/domain/usecase/auth/logout_use_case.dart';
import 'package:lemon_tree/domain/usecase/auth/sign_up_use_case.dart';
import 'package:lemon_tree/domain/usecase/tree/get_tree_count_use_case.dart';
import 'package:lemon_tree/presentation/auth/auth_view_model.dart';
import 'package:lemon_tree/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> setProviders() async {
  // 데이터 소스
  final tokenLocalDataSource = TokenLocalDataSource.instance;
  final authApi = AuthApi.instance;
  final tokenApi = TokenApi.instance;

  // 레포지토리
  final authRepository =
      AuthRepositoryImpl(authApi, tokenApi, tokenLocalDataSource);
  final treeRepository = TreeRepositoryImpl(tokenApi);

  // 유스케이스
  final List<SingleChildWidget> useCases = [
    // auth
    Provider(create: (context) => LoginWithEmailUseCase(authRepository)),
    Provider(create: (context) => LogoutUseCase(authRepository)),
    Provider(create: (context) => SignUpUseCase(authRepository)),

    // tree
    Provider(create: (context) => GetTreeCountUseCase(treeRepository)),
  ];

  // 뷰모델
  final List<SingleChildWidget> viewModels = [
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(
        context.read<LoginWithEmailUseCase>(),
        context.read<LogoutUseCase>(),
        context.read<SignUpUseCase>(),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        context.read<GetTreeCountUseCase>(),
      ),
    )
  ];

  return [
    ...useCases,
    ...viewModels,
  ];
}
