import 'package:flutter/material.dart';

import 'home_screen.dart';

class OptimizedListScreen extends StatelessWidget {
  const OptimizedListScreen({super.key});

  // ⚠️ Exemple statique de produits optimisés
  final List<Map<String, dynamic>> optimizedProducts = const [
    {"name": "Lait", "price": 2.5, "priority": 3},
    {"name": "Pain", "price": 1.5, "priority": 2},
    {"name": "Pâtes", "price": 1.2, "priority": 2},
  ];

  Widget _priorityIcon(int priority) {
    switch (priority) {
      case 3:
        return const Icon(Icons.star, color: Colors.orange);
      case 2:
        return const Icon(Icons.star_half, color: Colors.orange);
      default:
        return const Icon(Icons.star_border, color: Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEDC8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text("Liste optimisée"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: optimizedProducts.length,
        itemBuilder: (context, index) {
          final product = optimizedProducts[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: _priorityIcon(product['priority']),
              title: Text(product['name']),
              trailing: Text("${product['price'].toStringAsFixed(2)} €"),
            ),
          );
        },
      ),
    );
  }
}
