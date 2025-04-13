import 'package:flutter/material.dart';

import 'home_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final TextEditingController _budgetController = TextEditingController();
  final List<Map<String, dynamic>> _budgets = [];
  String _selectedCurrency = '€';

  final List<String> _currencies = ['€', '\$', '£', 'MAD'];

  void _saveBudget() {
    final budget = double.tryParse(_budgetController.text);
    if (budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un budget valide")),
      );
      return;
    }

    setState(() {
      _budgets.add({'amount': budget, 'currency': _selectedCurrency});
      _budgetController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Budget enregistré !")),
    );
  }

  void _deleteBudget(int index) {
    setState(() {
      _budgets.removeAt(index);
    });
  }

  void _editBudget(int index) {
    _budgetController.text = _budgets[index]['amount'].toString();
    _selectedCurrency = _budgets[index]['currency'];
    _budgets.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text("Définir mon budget"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
            ); // Ou Navigator.pushNamed(context, '/home'); selon ta logique
          },
        ),
      ),
    body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Quel est votre budget pour les courses ?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Montant",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCurrency = value;
                      });
                    }
                  },
                  items: _currencies
                      .map((currency) => DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBudget,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFABD55),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Valider le budget"),
            ),
            const SizedBox(height: 30),
            if (_budgets.isNotEmpty)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Budgets enregistrés :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _budgets.length,
                itemBuilder: (context, index) {
                  final budget = _budgets[index];
                  return Card(
                    child: ListTile(
                      title: Text("Budget : ${budget['amount'].toStringAsFixed(2)} ${budget['currency']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () => _editBudget(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteBudget(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}