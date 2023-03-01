import 'package:flutter/material.dart';
import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/models/utilisateur.dart';
import 'package:budget_app/services/api_trans.dart';

import 'package:budget_app/services/api_utli.dart';
import 'package:budget_app/transaction/affichetrans.dart';
import 'package:budget_app/transaction/edittrans.dart';




class Detailstrans extends StatefulWidget {
  Detailstrans(this.transaction);

  final Transaction transaction;

  @override
  _DetailstransState createState() => _DetailstransState();
}

class _DetailstransState extends State<Detailstrans> {
  _DetailstransState();

  final ApiTrans api = ApiTrans();

  @override
  Widget build(BuildContext context) {
    var title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('type:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.transaction.type, style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                       Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('montant:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.transaction.montant, style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                       Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('day:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.transaction.day, style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                       Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('descriptions:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.transaction.descriptions, style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      
                      
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Update Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
      
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                        
                            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14, color: Colors.white))),
                onPressed: () {
                                _navigateToEditScreen(context, widget.transaction);
                              },
                              child: Text('Edit', style: TextStyle(color: Colors.white)),
                 ),
                            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14, color: Colors.white))),
                onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Delete', style: TextStyle(color: Colors.white)),
                 ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen (BuildContext context, Transaction transaction) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Edittrans(transaction)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
              TextButton(
            child: Text(
              'yes',
            ), 
          style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: Colors.blue)),
             onPressed: () {
                api.deleteCase(widget.transaction.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                 content: Text("delete successful"),
                       ));
                  Navigator.pop(context) ;
              },
          ), 
               TextButton(
            child: Text(
              'no',
            ), 
          style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: Colors.blue)),
                  onPressed: () {
                Navigator.of(context).pop();
              },
          ),
          ],
        );
      },
    );
  }

}