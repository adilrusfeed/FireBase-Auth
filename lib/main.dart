import 'package:ecommerce/controller/auth_provider.dart';
import 'package:ecommerce/controller/bottom_provider.dart';
import 'package:ecommerce/controller/home_provider.dart';
import 'package:ecommerce/controller/image_provider.dart';
import 'package:ecommerce/controller/otp_provider.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/view/widgets/login/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProviders()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => imageProviders()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AuthGate()),
    );
  }
}
