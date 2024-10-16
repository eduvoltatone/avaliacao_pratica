import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/api.service.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiServiceImpl();
  List<Account> accounts = [];

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  void fetchAccounts() async {
    final data = await apiService.getAccounts();
    setState(() {
      accounts = data;
    });
  }

  void addAccount(Account account) async {
    await apiService.createAccount(account);
    fetchAccounts();
  }

  void editAccount(Account account) async {
    await apiService.updateAccount(account.id!, account);
    fetchAccounts();
  }

  void deleteAccount(int id) async {
    await apiService.deleteAccount(id);
    fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bank Accounts')),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return ListTile(
            title: Text(account.name),
            subtitle: Text('Balance: \$${account.balance}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(
                          account: account,
                          onSubmit: (updatedAccount) => editAccount(updatedAccount),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteAccount(account.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(
                onSubmit: (newAccount) => addAccount(newAccount),
              ),
            ),
          );
        },
      ),
    );
  }
}
