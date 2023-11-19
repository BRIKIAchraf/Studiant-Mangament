import 'dart:convert';
import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'Etudiant.dart';
import 'AddEtudiantPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ApiService apiService = ApiService();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController civiliteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etudiants'),
      ),
      body: FutureBuilder<List<Etudiant>>(
        future: widget.apiService.fetchEtudiants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No students available.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final etudiant = snapshot.data![index];
                return ListTile(
                  title: Text('${etudiant.nom} ${etudiant.prenom}'),
                  subtitle: Text(etudiant.civilite),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(etudiant);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteEtudiant(etudiant.id.toString());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showEditDialog(Etudiant etudiant) async {
    nomController.text = etudiant.nom;
    prenomController.text = etudiant.prenom;
    civiliteController.text = etudiant.civilite;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: prenomController,
              decoration: const InputDecoration(labelText: 'Prenom'),
            ),
            TextField(
              controller: civiliteController,
              decoration: const InputDecoration(labelText: 'Civilite'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _updateEtudiant(etudiant);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateEtudiant(Etudiant etudiant) async {
    try {
      etudiant.nom = nomController.text;
      etudiant.prenom = prenomController.text;
      etudiant.civilite = civiliteController.text;

      await widget.apiService.updateEtudiant(etudiant);

      setState(() {});
      print('Student updated successfully');
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  Future<void> _deleteEtudiant(String id) async {
    print('Deleting student with ID: $id');
    try {
      await widget.apiService.deleteEtudiant(id);
      setState(() {});
      print('Student deleted successfully');
    } catch (e) {
      print('Failed to delete student: $e');
    }
  }

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEtudiantPage()),
    ).then((value) {
      setState(() {});
    });
  }
}
