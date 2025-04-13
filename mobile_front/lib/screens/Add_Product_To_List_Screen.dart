import 'package:flutter/material.dart';

class AddProductToListScreen extends StatefulWidget {
  final String listId;

  const AddProductToListScreen({
    super.key,
    required this.listId,
  });

  @override
  State<AddProductToListScreen> createState() => _AddProductToListScreenState();
}

class _AddProductToListScreenState extends State<AddProductToListScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  int _priority = 1; // Priorité par défaut (1-3)

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // TODO: Ajouter le produit à Firestore
      // Pour l'instant, retournons simplement à l'écran précédent

      final productData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text.trim(),
        'price': double.parse(_priceController.text.trim()),
        'priority': _priority,
        'listId': widget.listId
      };

      // Ici vous implémenteriez la sauvegarde vers Firebase/Firestore
      print('Sauvegarde du produit: $productData');

      // Retourner à l'écran précédent avec les données du produit
      Navigator.pop(context, productData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text('Ajouter un produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du produit',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer un nom de produit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Prix (€)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  try {
                    final price = double.parse(value);
                    if (price <= 0) {
                      return 'Le prix doit être supérieur à 0';
                    }
                  } catch (e) {
                    return 'Veuillez entrer un prix valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Priorité:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPriorityOption(1, 'Basse', Icons.star_border),
                  _buildPriorityOption(2, 'Moyenne', Icons.star_half),
                  _buildPriorityOption(3, 'Haute', Icons.star),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityOption(int value, String label, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          _priority = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _priority == value ? const Color(0xFFF0F0F0) : Colors.white,
          border: Border.all(
            color: _priority == value ? const Color(0xFFFF9800) : Colors.grey,
            width: _priority == value ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.orange,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}