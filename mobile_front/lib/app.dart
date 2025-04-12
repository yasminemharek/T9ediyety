// app.dart
import 'package:appli/screens/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:appli/screens/splash_screen.dart';
import 'package:appli/screens/onboarding_screen.dart';
import 'package:appli/screens/login_screen.dart';
import 'package:appli/screens/register_screen.dart';
import 'package:appli/screens/home_screen.dart';
import 'package:appli/screens/budget_screen.dart';
import 'package:appli/screens/add_product_screen.dart';
import 'package:appli/screens/optimized_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'appli',
      theme: ThemeData(
        primaryColor: Color(0xFF4CAF50),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFF9800),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) =>  LoginScreen(),
        '/register': (context) =>  RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/budget': (context) =>  BudgetScreen(),
        '/add_product': (context) => AddProductScreen(),
        '/optimized_list': (context) =>  OptimizedListScreen(),
        '/profil':(context) => ProfileScreen(),
      },
    );
  }
}
