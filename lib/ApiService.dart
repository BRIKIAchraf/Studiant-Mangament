import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Etudiant.dart';

class ApiService {
  final String baseUrl = 'https://646d24937b42c06c3b2c9e2a.mockapi.io';

  Future<List<Etudiant>> fetchEtudiants() async {
    final apiUrl = '$baseUrl/Etudiant';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Etudiant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<void> deleteEtudiant(String id) async {
    if (id == null || id.isEmpty) {
      print('Invalid student ID: $id');
      return;
    }

    final apiUrl = '$baseUrl/Etudiant/$id';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Student deleted successfully');
      } else {
        print('Failed to delete student. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error deleting student: $e');
    }
  }

  Future<void> updateEtudiant(Etudiant etudiant) async {
    final apiUrl = '$baseUrl/Etudiant/${etudiant.id}';
    try {
      final Map<String, dynamic> etudiantMap = {
        'Nom': etudiant.nom,
        'Prenom': etudiant.prenom,
        'Civilite': etudiant.civilite,
        'Specialite': etudiant.specialite,
        'Langues': etudiant.langues,
      };

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(etudiantMap),
      );

      if (response.statusCode != 200) {
        print('Failed to update student. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update student');
      }
    } catch (e) {
      print('Error updating student: $e');
      throw Exception('Failed to update student');
    }
  }

  Future<void> addEtudiant(Etudiant etudiant) async {
    try {
      final String apiUrl = '$baseUrl/Etudiant';

      final Map<String, dynamic> etudiantMap = {
        'Nom': etudiant.nom,
        'Prenom': etudiant.prenom,
        'Civilite': etudiant.civilite,
        'Specialite': etudiant.specialite,
        'Langues': etudiant.langues,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(etudiantMap),
      );

      if (response.statusCode == 201) {
        print('Student added successfully: ${response.body}');
      } else {
        print('Failed to add student. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error adding student: $e');
    }
  }
}
