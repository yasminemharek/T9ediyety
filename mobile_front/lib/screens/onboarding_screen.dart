import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Garder la même structure de map que dans votre code original
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Bienvenue sur T9ediyety",
      "description": "L'application qui optimise vos courses en supermarché.",
      "image": "assets/images/onboard12.png"
    },
    {
      "title": "Fixez votre budget",
      "description": "Définissez votre budget pour des achats maîtrisés.",
      "image": "assets/images/onboard2.png"
    },
    {
      "title": "Liste intelligente",
      "description": "Recevez une liste optimisée selon vos priorités.",
      "image": "assets/images/onboard3.png"
    },
  ];

  void _nextPage() async {
    if (_currentPage == onboardingData.length - 1) {
      try {
        // Save preference in background
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool('onboarding_seen', true);
        });

        // Navigate immediately without waiting
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      } catch (e) {
        print("Navigation error: $e");
      }
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Méthodes UI
  Widget _buildPageContent(int index) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Zone pour l'image avec un fond semi-transparent
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFDAEBC6), // Fond vert très clair
              borderRadius: BorderRadius.circular(38),
            ),
            child: Stack(
              children: [
                // Éléments décoratifs
                _buildDecorativeElements(),
                // L'image centrale
                Center(
                  child: Image.asset(
                    onboardingData[index]['image']!,
                    height: 500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            onboardingData[index]['title']!,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            onboardingData[index]['description']!,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
            (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? const Color(0xFF689F38) // Couleur verte active
                : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF689F38), // Couleur verte
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          _currentPage == onboardingData.length - 1 ? "Commencer" : "Suivant",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeElements() {
    return Stack(
      children: [
        // Points, cercles, X et + décoratifs
        Positioned(top: 30, left: 50, child: _decorativeDot(Colors.green[800]!, 6)),
        Positioned(top: 120, right: 40, child: _decorativeDot(Colors.red[300]!, 4)),
        Positioned(bottom: 60, left: 70, child: _decorativeDot(Colors.green[800]!, 5)),
        Positioned(bottom: 30, right: 60, child: _decorativeDot(Colors.red[300]!, 4)),
        Positioned(
            top: 45,
            left: 110,
            child: Text("+", style: TextStyle(color: Colors.green[800], fontSize: 14))
        ),
        Positioned(
            right: 110,
            top: 130,
            child: Text("×", style: TextStyle(color: Colors.green[800], fontSize: 14))
        ),
        Positioned(
            bottom: 120,
            right: 95,
            child: Text(".", style: TextStyle(color: Colors.red[300], fontSize: 24))
        ),
        Positioned(
            bottom: 60,
            right: 130,
            child: Text("*", style: TextStyle(color: Colors.green[700], fontSize: 18))
        ),
      ],
    );
  }

  Widget _decorativeDot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEDC8), // Couleur de fond légèrement verdâtre
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => _buildPageContent(index),
              ),
            ),
            _buildPageIndicators(),
            _buildNavigationButton(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                );
              },
              child: const Text(
                "Passer",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
