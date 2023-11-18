import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'Etudiant.dart';

class AddEtudiantPage extends StatefulWidget {
  @override
  _AddEtudiantPageState createState() => _AddEtudiantPageState();
}

class _AddEtudiantPageState extends State<AddEtudiantPage> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController civiliteController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Etudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: prenomController,
              decoration: InputDecoration(labelText: 'Prenom'),
            ),
            TextField(
              controller: civiliteController,
              decoration: InputDecoration(labelText: 'Civilite'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveEtudiant();
                // Navigate back to the main page after saving
                Navigator.pop(context);
              },
              child: Text('Enregister'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveEtudiant() async {
    try {
      // Create a new Etudiant object with the entered details
      final newEtudiant = Etudiant(
        nom: nomController.text,
        prenom: prenomController.text,
        civilite: civiliteController.text, id: '', specialite: [], langues: [],
      );

      // Call the API service to add the new element
      await apiService.addEtudiant(newEtudiant);

      print('Student added successfully');
    } catch (e) {
      print('Failed to add student: $e');
    }
  }
}
