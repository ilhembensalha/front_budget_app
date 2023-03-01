import 'dart:convert';
import 'package:http/http.dart';
import 'package:budget_app/models/transaction.dart';


class ApiTrans {
  final String apiUrl = "";

  Future<List<Transaction>> getCat() async {
    Response res = await get(Uri.parse('http://192.168.1.31:3000/api/transaction'));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Transaction> transaction = body.map((dynamic item) => Transaction.fromJson(item)).toList();
      return transaction;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Transaction> getCaseById(String id) async {
    final response = await get(Uri.parse('http://192.168.1.31:3000/api/transaction/$id'));

    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Transaction> createCase(Transaction transaction) async {
    Map data = {
       //'day': transaction.day,
       'montant':transaction.montant,
       'descriptions':transaction.descriptions,
       'type':transaction.type
      
 
    };

    final Response response = await post(
     Uri.parse('http://192.168.1.31:3000/api/transaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post Transaction');
    }
  }

  Future<Transaction> updateCases(String id, Transaction transaction) async {
    Map data = {
       'day': transaction.day,
       'montant':transaction.montant,
       'descriptions':transaction.descriptions,
       'type':transaction.type
     
    };

    final Response response = await put(
      (Uri.parse('http://192.168.1.31:3000/api/transaction/$id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a Transaction');
    }
  }

  Future<void> deleteCase(String id) async {
    Response res = await delete((Uri.parse('http://192.168.1.31:3000/api/transaction/$id')));

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }

}
