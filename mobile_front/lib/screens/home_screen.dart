import 'package:appli/screens/product_screen.dart';
import 'package:appli/screens/budget_screen.dart';
import 'package:appli/screens/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'optimized_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hey 👋", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        Text(
                          "Gérez votre budget intelligemment",
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/user.jpg"),
                      radius: 22,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Rechercher un produit...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Catégories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Catégories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Voir tout", style: TextStyle(color: Colors.green))
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _CategoryCard("Légumes", Icons.eco),
                      _CategoryCard("Fruits", Icons.apple),
                      _CategoryCard("Viandes", Icons.set_meal),
                      _CategoryCard("Snacks", Icons.fastfood),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Promo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("30% de réduction", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Commandez maintenant et profitez de l'offre !"),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Produits populaires
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Offres populaires", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Voir tout", style: TextStyle(color: Colors.green))
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _PopularDeal(image: 'assets/images/food1.jpg'),
                      _PopularDeal(image: 'assets/images/food2.jpg'),
                      _PopularDeal(image: 'assets/images/food3.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Barre de navigation en bas
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(builder: (context) => const BudgetScreen()),
                    (route) => false,
          );
              break;
            case 1:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const  ProfileScreen()),
                    (route) => false,
              );;
              break;
            case 2:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ProductScreen()),
                    (route) => false,
              );
              break;
            case 3:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OptimizedListScreen()),
                    (route) => false,
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Mon budget'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mon profil'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Ma liste'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historique'),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  const _CategoryCard(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green[700], size: 30),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}

class _PopularDeal extends StatelessWidget {
  final String image;
  const _PopularDeal({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
