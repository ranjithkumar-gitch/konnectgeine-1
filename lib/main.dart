import 'package:KonnectGenie/authentication/splash_screen.dart';

import 'package:KonnectGenie/sharedpreferences/sharedprefservices.dart';
import 'package:KonnectGenie/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2C5AA0),
            primary: const Color(0xFF2C5AA0),
            secondary: const Color(0xFF1E3A8A),
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: Colors.white,
            elevation: 14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFE0E9F7)),
            ),
            titleTextStyle: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E3A8A),
            ),
            contentTextStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF334E68),
              height: 1.35,
            ),
            actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1E3A8A),
              textStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
