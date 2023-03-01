import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:budget_app/category/addcat.dart';
import 'package:budget_app/category/categorylist.dart';
import 'package:budget_app/models/categories.dart';
import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/services/api.dart';

import 'dart:async';

import 'package:budget_app/services/api_trans.dart';
import 'package:budget_app/transaction/addtrans.dart';
import 'package:budget_app/transaction/transactionlist.dart';




class home extends StatefulWidget {
home({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
   final ApiTrans api = ApiTrans();
  List<Transaction> transactionList=[];

  @override
  Widget build(BuildContext context) {
    if(transactionList == null) {
      transactionList = <Transaction>[];
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: new Container(
        child: new Center(
            child: new FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                return transactionList.length > 0? new TransactionList(transaction: transactionList):
                new Center(child:
                new Text('No data found, tap plus button to add!', style: Theme.of(context).textTheme.headline6));
              },
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
 Future loadList() {
    Future<List<Transaction>> futureCases = api.getCat();
    futureCases.then((transactionList) {
      setState(() {
        this.transactionList = transactionList;
      });
    });
    return futureCases;
  }

  _navigateToAddScreen (BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Addtrans()),
    );
  }
}
