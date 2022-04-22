import 'package:flutter/material.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGreen,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
