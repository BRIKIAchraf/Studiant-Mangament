import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
    final apiUrl = '$baseUrl/Etudiant/$id';
    final response = await http.delete(Uri.parse(apiUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  }

  Future<void> updateEtudiant(Etudiant etudiant) async {
    final apiUrl = '$baseUrl/Etudiant/${etudiant.id}';
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(etudiant.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }

  Future<void> addEtudiant(Etudiant etudiant) async {
    try {
      final String apiUrl = '$baseUrl/Etudiant'; // Use the correct endpoint

      final Map<String, dynamic> etudiantMap = {
        'Nom': etudiant.nom,
        'Prenom': etudiant.prenom,
        'Civilite': etudiant.civilite,
        'Specialite': etudiant.specialite,
        'Langues': etudiant.langues,
      };

      final Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(etudiantMap),
      );

      if (response.statusCode == 201) {
        print('Student added successfully: ${response.body}');
      } else {
        print('Failed to add student. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding student: $e');
    }
  }
}
