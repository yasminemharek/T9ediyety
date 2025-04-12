import 'package:flutter/material.dart';

import 'home_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int _priority = 2; // 1 = basse, 2 = moyenne, 3 = haute

  void _addProduct() {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text);

    if (name.isEmpty || price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    // TODO: Ajouter le produit à Firestore
    print("Produit ajouté : $name, $price €, priorité $_priority");

    Navigator.pop(context); // Retour à l'accueil
  }

  Widget _prioritySelector(String label, int value, Icon icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _priority = value),
        child: Container(
          decoration: BoxDecoration(
            color: _priority == value ? Colors.orange[100] : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              icon,
              const SizedBox(height: 6),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEDC8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text("Ajouter un produit"),
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nom du produit",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Prix en €",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Priorité :"),
            const SizedBox(height: 10),
            Row(
              children: [
                _prioritySelector("Basse", 1, const Icon(Icons.star_border)),
                const SizedBox(width: 10),
                _prioritySelector("Moyenne", 2, const Icon(Icons.star_half)),
                const SizedBox(width: 10),
                _prioritySelector("Haute", 3, const Icon(Icons.star)),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _addProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
