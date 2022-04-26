import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lemon_tree/core/di/provider_setting.dart';
import 'package:lemon_tree/presentation/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final providers = await setProviders();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.requestFocus(focusNode);
        }
      },
      child: MaterialApp(
        title: 'lemon tree',
        theme: ThemeData(primaryColor: Colors.blue),
        home: ResponsiveSizer(
            builder: (context, orientation, screenType) => const AuthGate()),
      ),
    );
  }
}
