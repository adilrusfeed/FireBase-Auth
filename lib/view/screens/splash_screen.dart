// import 'package:ecommerce/controller/spash_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SplashProvider>(
//       builder: (context, value, _) {
//         if (!value.isLoading) {
//           WidgetsBinding.instance!.addPostFrameCallback((_) {
//             Navigator.of(context).pushReplacementNamed('/home');
//           });
//         }
//         return const Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         )
//       },
//     );
//   }
// }
