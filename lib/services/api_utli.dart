import 'dart:convert';
import 'package:http/http.dart';
import 'package:budget_app/models/utilisateur.dart';

class ApiUtli {
 


  Future<List<Utilisateur>> getCat() async {
    Response res = await get(  (Uri.parse('http://192.168.1.31:3000/api/utilisateur')));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Utilisateur> utilisateur = body.map((dynamic item) => Utilisateur.fromJson(item)).toList();
      return utilisateur;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Utilisateur> getCaseById(String id) async {
    final response = await get(  (Uri.parse('http://192.168.1.31:3000/api/utilisateur/$id')));

    if (response.statusCode == 200) {
      return Utilisateur.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Utilisateur> createCase(Utilisateur utilisateur) async {
    Map data = {
      'nom': utilisateur.nom,
       'prenom':utilisateur.prenom,
       'adresse':utilisateur.adresse,
       'telephone':utilisateur.telephone,
      ' email':utilisateur.email,
       'username':utilisateur.username,
      ' password':utilisateur.password,
     // ' role':utilisateur.role
      
    };

    final Response response = await post(
        (Uri.parse('http://192.168.1.31:3000/api/utilisateur')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Utilisateur.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post utilisateur');
    }
  }

  Future<Utilisateur> updateCases(String id, Utilisateur utilisateur) async {
    Map data = {
    'nom': utilisateur.nom,
       'prenom':utilisateur.prenom,
       'adresse':utilisateur.adresse,
       'telephone':utilisateur.telephone,
      ' email':utilisateur.email,
       'username':utilisateur.username,
      ' password':utilisateur.password,
     // ' role':utilisateur.role
     
    };

    final Response response = await put(
        (Uri.parse('http://192.168.1.31:3000/api/utilisateur/$id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Utilisateur.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a utilisateur');
    }
  }

  Future<void> deleteCase(String id) async {
    Response res = await delete(  (Uri.parse('http://192.168.1.31:3000/api/utilisateur/$id')));

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }

}
