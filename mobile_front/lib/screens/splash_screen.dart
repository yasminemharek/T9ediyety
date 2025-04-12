import 'dart:async';
import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Déclaration de l'AnimationController
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialisation de l'AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animation de zoom (commence à 0.5 et va jusqu'à 1.0)
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Démarrer l'animation dès que l'écran est construit
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Important pour éviter les fuites de mémoire
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEDC8),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/logo.png',
            width: 350,
            height: 350,
          ),
        ),
      ),
    );
  }
}