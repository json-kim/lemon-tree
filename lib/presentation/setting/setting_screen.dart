import 'package:flutter/material.dart';
import 'package:lemon_tree/presentation/auth/auth_event.dart';
import 'package:lemon_tree/presentation/auth/auth_view_model.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/constants/ui_constants.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGreen,
      appBar: AppBar(
        title: const Text('설정화면', style: defStyle),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () async {
                  final dialog = AlertDialog(
                    backgroundColor: mainGreen,
                    content: const Text(
                      '정말로 로그아웃하시겠어요?',
                      style: defStyle,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop<bool>(false);
                          },
                          child: const Text(
                            '취소',
                            style: defStyle,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop<bool>(true);
                          },
                          child: const Text(
                            '로그아웃',
                            style: defStyle,
                          )),
                    ],
                  );

                  final logoutCheck = await showDialog(
                      context: context, builder: (context) => dialog);

                  if (logoutCheck == true) {
                    context.read<AuthViewModel>().onEvent(AuthEvent.logOut());
                    Navigator.of(context).pop();
                  }
                },
                child: SizedBox(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: const [
                        Text(
                          '로그아웃',
                          style: defStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(color: Colors.white),
            ],
          ),
          // if (settingViewModel.isLoading)
          //   Container(
          //     color: Colors.transparent,
          //     alignment: Alignment.center,
          //     child: const CircularProgressIndicator(),
          //   ),
        ],
      ),
    );
  }
}
