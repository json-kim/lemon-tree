import 'package:flutter/material.dart';
import 'package:lemon_tree/data/data_source/local/token_local_data_source.dart';
import 'package:lemon_tree/presentation/auth/auth_view_model.dart';
import 'package:lemon_tree/presentation/tab_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'auth/auth_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();

    return FutureBuilder<String?>(
        future: TokenLocalDataSource.instance.loadAccessToken(),
        builder: (context, snapshot) {
          Logger().i(snapshot.data);
          if (!snapshot.hasData || snapshot.data == null) {
            return const AuthScreen();
          }

          return const TabScreen();
        });
  }
}
