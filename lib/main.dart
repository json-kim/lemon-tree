import 'package:flutter/material.dart';
import 'package:lemon_tree/core/di/provider_setting.dart';
import 'package:lemon_tree/presentation/auth/auth_screen.dart';
import 'package:lemon_tree/presentation/auth_gate.dart';
import 'package:lemon_tree/presentation/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  final providers = await setProviders();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lemon tree',
      theme: ThemeData(primaryColor: Colors.blue),
      home: ResponsiveSizer(
          builder: (context, orientation, screenType) => const AuthGate()),
    );
  }
}
