import 'package:appli/screens/product_screen.dart';
import 'package:flutter/material.dart';

import 'Add_Product_To_List_Screen.dart';
// Importez votre BudgetScreen pour accéder aux budgets existants
import 'budget_screen.dart'; // Assurez-vous que ce chemin d'importation est correct

class ListDetailScreen extends StatefulWidget {
  final String listId;
  final String listName;

  const ListDetailScreen({
    super.key,
    required this.listId,
    required this.listName,
  });

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  bool _showBudget = false;
  double _budget = 0.0;
  final TextEditingController _budgetController = TextEditingController();

  // Dummy products data - would be replaced with Firestore data
  final List<Map<String, dynamic>> _products = [
    {'id': '1', 'name': 'Produit 1', 'price': 5.99, 'priority': 2, 'isChecked': false},
    {'id': '2', 'name': 'Produit 2', 'price': 3.49, 'priority': 3, 'isChecked': false},
    {'id': '3', 'name': 'Produit 3', 'price': 1.99, 'priority': 1, 'isChecked': false},
  ];

  // Exemple de budgets existants - à remplacer par les données de votre BudgetScreen
  final List<Map<String, dynamic>> _existingBudgets = [
    {'id': '1', 'name': 'Budget alimentation', 'amount': 100.0},
    {'id': '2', 'name': 'Budget fournitures', 'amount': 50.0},
    {'id': '3', 'name': 'Budget fêtes', 'amount': 200.0},
  ];

  @override
  void initState() {
    super.initState();
    _budgetController.text = _budget.toString();
    // Ici vous pourriez charger les budgets depuis Firestore
  }

  void _toggleBudget(bool value) {
    setState(() {
      _showBudget = value;
    });
    if (value) {
      _showBudgetSelectionDialog();
    }
  }

  void _showBudgetSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choisir un budget"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _existingBudgets.length + 1, // +1 pour l'option "Nouveau budget"
            itemBuilder: (context, index) {
              if (index == _existingBudgets.length) {
                // Option pour créer un nouveau budget
                return ListTile(
                  leading: const Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
                  title: const Text("Nouveau budget"),
                  onTap: () {
                    Navigator.pop(context);
                    _showNewBudgetDialog();
                  },
                );
              } else {
                final budget = _existingBudgets[index];
                return ListTile(
                  leading: const Icon(Icons.account_balance_wallet, color: Color(0xFFFF9800)),
                  title: Text(budget['name']),
                  subtitle: Text("${budget['amount']} €"),
                  onTap: () {
                    setState(() {
                      _budget = budget['amount'];
                      _budgetController.text = _budget.toString();
                    });
                    Navigator.pop(context);
                  },
                );
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _showBudget = false;
              });
            },
            child: const Text("Annuler"),
          ),
        ],
      ),
    );
  }

  void _showNewBudgetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Définir un nouveau budget"),
        content: TextField(
          controller: _budgetController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Budget en €",
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _showBudget = false;
              });
            },
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(_budgetController.text);
              if (value != null && value > 0) {
                setState(() {
                  _budget = value;
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Veuillez entrer un montant valide")),
                );
              }
            },
            child: const Text("Confirmer"),
          ),
        ],
      ),
    );
  }

  Icon _getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.star_border, color: Colors.orange);
      case 2:
        return const Icon(Icons.star_half, color: Colors.orange);
      case 3:
        return const Icon(Icons.star, color: Colors.orange);
      default:
        return const Icon(Icons.star_border, color: Colors.orange);
    }
  }

  double get _totalPrice {
    return _products.fold(0, (sum, product) => sum + (product['price'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text(widget.listName),
        actions: [
          // Vous pourriez ajouter un bouton d'actions ici si nécessaire
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Total: ${_totalPrice.toStringAsFixed(2)} €",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text("Budget"),
                    Switch(
                      value: _showBudget,
                      onChanged: _toggleBudget,
                      activeColor: const Color(0xFFFF9800),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_showBudget)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Budget: ${_budget.toStringAsFixed(2)} €",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Reste: ${(_budget - _totalPrice).toStringAsFixed(2)} €",
                    style: TextStyle(
                      fontSize: 16,
                      color: _budget >= _totalPrice ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          const Divider(thickness: 1),
          Expanded(
            child: _products.isEmpty
                ? const Center(
              child: Text(
                "Aucun produit dans cette liste",
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: CheckboxListTile(
                    value: product['isChecked'] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        product['isChecked'] = value ?? false;
                      });
                    },
                    title: Text(
                      product['name'],
                      style: TextStyle(
                        decoration: product['isChecked'] == true
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text("${product['price']} €"),
                    secondary: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getPriorityIcon(product['priority']),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _products.removeWhere((p) => p['id'] == product['id']);
                            });
                          },
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Navigation vers l'écran d'ajout de produit
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddProductToListScreen(listId: widget.listId),
                  ),
                );

                // Vérifier si un produit a été retourné
                if (result != null && mounted) {
                  // Ajouter la propriété isChecked au nouveau produit
                  result['isChecked'] = false;

                  setState(() {
                    _products.add(result);
                  });

                  // Afficher un message de confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Produit ajouté avec succès")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Ajouter un produit"),
            ),
          )
        ],
      ),
    );
  }
}