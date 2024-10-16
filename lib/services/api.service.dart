import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';

abstract class ApiService {
  final String apiUrl = 'http://localhost:3000/accounts';

  Future<List<Account>> getAccounts();
  Future<Account> createAccount(Account account);
  Future<Account> updateAccount(int id, Account account);
  Future<void> deleteAccount(int id);
}

class ApiServiceImpl extends ApiService {
  @override
  Future<List<Account>> getAccounts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Account.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load accounts');
    }
  }

  @override
  Future<Account> createAccount(Account account) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(account.toJson()),
    );
    if (response.statusCode == 201) {
      return Account.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create account');
    }
  }

  @override
  Future<Account> updateAccount(int id, Account account) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(account.toJson()),
    );
    if (response.statusCode == 200) {
      return Account.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update account');
    }
  }

  @override
  Future<void> deleteAccount(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete account');
    }
  }
}
