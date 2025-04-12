import 'package:appli/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isForgotPasswordPressed = false;
  bool _isRegisterPressed = false;

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    // TODO: Implémenter Firebase Auth ici

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }


  void _loginWithGoogle() {
    // TODO: Implémenter Google Sign-In avec Firebase
    print("Connexion avec Google");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 40),
                // Logo ou icône de l'application
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F9F0),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 350,
                    height: 350,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Connectez-vous",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D31),
                  ),
                ),
                const SizedBox(height: 40),
                // Champ email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Color(0xFF689F38)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[220],
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF689F38)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
                const SizedBox(height: 20),
                // Champ mot de passe
                TextField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    labelStyle: const TextStyle(color: Color(0xFF689F38)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[220],
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF689F38)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _isForgotPasswordPressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isForgotPasswordPressed = false;
                      });
                      // TODO: Implement forgot password
                      print("Mot de passe oublié");
                    },
                    onTapCancel: () {
                      setState(() {
                        _isForgotPasswordPressed = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Mot de passe oublié?",
                        style: TextStyle(
                          color: const Color(0xFF689F38),
                          fontSize: 14,
                          decoration: _isForgotPasswordPressed
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Bouton de connexion
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC34A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                // Lien d'inscription
                GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      _isRegisterPressed = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      _isRegisterPressed = false;
                    });
                    Navigator.pushNamed(context, '/register');
                  },
                  onTapCancel: () {
                    setState(() {
                      _isRegisterPressed = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Pas encore de compte? ",
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                        children: [
                          TextSpan(
                            text: "Inscrivez-vous",
                            style: TextStyle(
                              color: const Color(0xFF689F38),
                              fontWeight: FontWeight.bold,
                              decoration: _isRegisterPressed
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationThickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Séparateur "Ou"
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Ou", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                // Bouton Google
                OutlinedButton.icon(
                  onPressed: _loginWithGoogle,
                  icon: const Icon(Icons.login),
                  label: const Text(
                    "Continuer avec Google",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  style:OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey[700],
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}