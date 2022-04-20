import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/ui_constants.dart';
import 'auth_event.dart';
import 'auth_view_model.dart';
import 'sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final viewModel = context.read<AuthViewModel>();

      _subscription = viewModel.uiEventStream.listen((event) {
        event.whenOrNull(snackBar: (message) {
          final snackBar = SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
          );

          _messengerKey.currentState
            ?..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _loginWithEmail() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    context
        .read<AuthViewModel>()
        .onEvent(AuthEvent.loginWithEmail(email, password));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();

    return ScaffoldMessenger(
      key: _messengerKey,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Image.asset(
                      'asset/image/lemon.png',
                      width: 40.w,
                    ),
                    SizedBox(height: 8.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 4),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (text) {
                                if (text?.isEmpty ?? false) {
                                  return '이메일을 입력해주세요';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: formDecoration.copyWith(
                                  labelText: '이메일',
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  )),
                              cursorColor: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 4),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (text) {
                                if (text?.isEmpty ?? false) {
                                  return '비밀번호를 입력해주세요';
                                }

                                return null;
                              },
                              obscureText: true,
                              decoration: formDecoration.copyWith(
                                  labelText: '비밀번호',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  )),
                              cursorColor: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          maximumSize: Size(double.infinity, 64),
                          minimumSize: Size(double.infinity, 64),
                          primary: Colors.white,
                          // onSurface: Colors.grey,
                          onPrimary: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: _loginWithEmail,
                        child: Text(
                          '로그인',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ));
                              },
                              child: const Text(
                                '회원가입',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
            if (viewModel.isLoading)
              Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
