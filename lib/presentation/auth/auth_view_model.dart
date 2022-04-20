import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lemon_tree/data/data_source/remote/auth_api.dart';
import 'package:lemon_tree/domain/usecase/auth/login_with_email_use_case.dart';
import 'package:lemon_tree/domain/usecase/auth/logout_use_case.dart';
import 'package:lemon_tree/domain/usecase/auth/sign_up_use_case.dart';

import 'auth_event.dart';
import 'auth_ui_event.dart';

class AuthViewModel with ChangeNotifier {
  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final LogoutUseCase _logoutUseCase;
  final SignUpUseCase _signUpUseCase;

  final _streamController = StreamController<AuthUiEvent>.broadcast();
  Stream<AuthUiEvent> get uiEventStream => _streamController.stream;
  final _signUpController = StreamController<AuthUiEvent>.broadcast();
  Stream<AuthUiEvent> get signUpEvent => _signUpController.stream;

  bool isLoading = false;

  AuthViewModel(
    this._loginWithEmailUseCase,
    this._logoutUseCase,
    this._signUpUseCase,
  );

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onEvent(AuthEvent event) {
    event.when(
        loginWithEmail: _loginWithEmail, signUp: _signUp, logOut: _logOut);
  }

  Future<void> _loginWithEmail(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await _loginWithEmailUseCase(email, password);

    result.when(
        success: (_) {
          _streamController.add(const AuthUiEvent.snackBar('로그인에 성공했습니다.'));
        },
        error: (error) {});

    isLoading = false;
    notifyListeners();
  }

  Future<void> _signUp(String email, String password, String name) async {
    isLoading = true;
    notifyListeners();

    final result = await _signUpUseCase(email, password, name);

    result.when(
        success: (_) {
          _signUpController.add(const AuthUiEvent.signUpSuccess());
          _streamController.add(const AuthUiEvent.snackBar('회원가입 되셨습니다.'));
        },
        error: (error) {});

    isLoading = false;
    notifyListeners();
  }

  Future<void> _logOut() async {
    final result = await _logoutUseCase();

    _streamController.add(const AuthUiEvent.snackBar('로그아웃 되었습니다.'));
    notifyListeners();
  }
}
