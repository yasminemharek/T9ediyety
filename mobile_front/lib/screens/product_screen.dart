import 'package:flutter/material.dart';
// Import these screens from your project
import 'list_detail_screen.dart';
// You'll need to create these screens if they don't exist yet
import 'list_detail_screen.dart';
import 'package:appli/screens/profil_screen.dart';
import 'home_screen.dart';
import 'budget_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _newListController = TextEditingController();
  // Dummy lists for now - would be replaced with Firestore data
  final List<Map<String, dynamic>> _lists = [
    {'id': '1', 'name': 'Liste 1', 'productCount': 5},
    {'id': '2', 'name': 'Liste 2', 'productCount': 3},
    {'id': '3', 'name': 'Liste 3', 'productCount': 8},
  ];

  void _createNewList() {
    final name = _newListController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un nom de liste")),
      );
      return;
    }

    // TODO: Add list to Firestore
    setState(() {
      _lists.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'productCount': 0,
      });
    });
    _newListController.clear();
    Navigator.pop(context);
  }

  void _showAddListDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Nouvelle liste"),
        content: TextField(
          controller: _newListController,
          decoration: const InputDecoration(
            labelText: "Nom de la liste",
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              _createNewList();
            },
            child: const Text("Créer"),
          ),
        ],
      ),
    );
  }

  void _navigateToListDetail(String listId, String listName) {
    // Navigate to list detail screen with the selected list
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListDetailScreen(
          listId: listId,
          listName: listName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text("Ma Liste"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
            ); // Ou Navigator.pushNamed(context, '/home'); selon ta logique
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddListDialog,
          ),

        ],
      ),
      body: _lists.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Aucune liste pour le moment",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showAddListDialog,
              icon: const Icon(Icons.add),
              label: const Text("Créer une liste"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lists.length,
        itemBuilder: (context, index) {
          final list = _lists[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                list['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("${list['productCount']} produits"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF4CAF50)),
                    onPressed: () {
                      // Edit list name functionality
                      _showEditListDialog(list);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Delete list functionality
                      _showDeleteListDialog(list['id']);
                    },
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              onTap: () => _navigateToListDetail(
                list['id'],
                list['name'],
              ),
            ),
          );
        },
      ),
    );
  }

  // Edit list dialog
  void _showEditListDialog(Map<String, dynamic> list) {
    final editController = TextEditingController(text: list['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Modifier la liste"),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            labelText: "Nom de la liste",
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              final newName = editController.text.trim();
              if (newName.isNotEmpty) {
                setState(() {
                  final index = _lists.indexWhere((item) => item['id'] == list['id']);
                  if (index != -1) {
                    _lists[index]['name'] = newName;
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Enregistrer"),
          ),
        ],
      ),
    );
  }

  // Delete list dialog
  void _showDeleteListDialog(String listId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer la liste"),
        content: const Text("Êtes-vous sûr de vouloir supprimer cette liste?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _lists.removeWhere((list) => list['id'] == listId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Liste supprimée")),
              );
            },
            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}