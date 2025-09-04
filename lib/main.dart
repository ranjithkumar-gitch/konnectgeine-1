// import 'package:KonnectGenie/authentication/splash_screen.dart';

// import 'package:KonnectGenie/viewmodels/login_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
//       ],
//       child: MaterialApp(
//         title: 'KonnectGeine',
//         navigatorKey: navigatorKey,
//         builder: BotToastInit(),
//         debugShowCheckedModeBanner: false,
//         // theme: ThemeData(
//         //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         //   useMaterial3: true,
//         // ),
//         theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }
import 'package:KonnectGenie/authentication/splash_screen.dart';

import 'package:KonnectGenie/sharedpreferences/sharedprefservices.dart';
import 'package:KonnectGenie/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize shared preferences before app starts
  await SharedPrefServices.init();
  final token = SharedPrefServices.gettoken();
  print("🔑 Saved token: $token");

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        title: 'KonnectGeine',
        navigatorKey: navigatorKey,
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
        home: const SplashScreen(),
      ),
    );
  }
}
