class Etudiant {
  String _nom;
  String _prenom;
  String _civilite;
  List<String> _specialite;
  List<String> _langues;
  String id; // Add a property to store the ID

  Etudiant({
    String nom = '',
    String prenom = '',
    String civilite = '',
    List<String> specialite = const [],
    List<String> langues = const [],
    required this.id, // Update the constructor to accept an 'id'
  })  : _nom = nom,
        _prenom = prenom,
        _civilite = civilite,
        _specialite = specialite,
        _langues = langues;

  String get nom => _nom;
  String get prenom => _prenom;
  String get civilite => _civilite;
  List<String> get specialite => _specialite;
  List<String> get langues => _langues;

  set nom(String value) {
    _nom = value;
  }

  set prenom(String value) {
    _prenom = value;
  }

  set civilite(String value) {
    _civilite = value;
  }

  set specialite(List<String> value) {
    _specialite = value;
  }

  set langues(List<String> value) {
    _langues = value;
  }

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'] ?? '',
      nom: json['Nom'] ?? '',
      prenom: json['Prenom'] ?? '',
      civilite: json['Civilite'] ?? '',
      specialite: (json['Specialite'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      langues: (json['Langues'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Nom': nom,
      'Prenom': prenom,
      'Civilite': civilite,
      'Specialite': specialite,
      'Langues': langues,
    };
  }
}
