import 'package:flutter/material.dart';
import 'package:budget_app/models/transaction.dart';

import 'package:budget_app/models/utilisateur.dart';
import 'package:budget_app/services/api_trans.dart';
import 'package:budget_app/services/api_utli.dart';

enum Type { revenu, depence,transfert }

class Addtrans extends StatefulWidget {
  Addtrans();

  @override
  _AddtransState createState() => _AddtransState();
}

class _AddtransState extends State<Addtrans> {
  _AddtransState();

  final ApiTrans api = ApiTrans();
  final _addFormKey = GlobalKey<FormState>();
   final _montantController = TextEditingController();
  final _descriptionsController = TextEditingController();
  //final _typeController = TextEditingController();
  String type = 'revenu';
  Type _type = Type.revenu;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add transaction'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
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
                              Text('montant'),
                              TextFormField(
                                controller: _montantController,
                                decoration: const InputDecoration(
                                  hintText: 'montant',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter montant';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ), Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('descriptions'),
                              TextFormField(
                                controller: _descriptionsController,
                                decoration: const InputDecoration(
                                  hintText: 'descriptions',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter descriptions';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
            /*   Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('type'),
                              TextFormField(
                                controller: _typeController,
                                decoration: const InputDecoration(
                                  hintText: 'type',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter type';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),*/
                       Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('type'),
                              ListTile(
                                title: const Text('revenu'),
                                  leading: Radio(
                                  value: Type.revenu,
                                  groupValue: _type,
                                  onChanged: ( value) {
                                    setState(() {
                                      _type = Type.revenu;
                                      type = 'revenu';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('depence'),
                               leading: Radio(
                                  value: Type.depence,
                                  groupValue: _type,
                                  onChanged: (value) {
                                    setState(() {
                                      _type = Type.depence;
                                      type = 'depence';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('transfert'),
                                leading: Radio(
                                value  : Type.transfert,
                                  groupValue: _type,
                                  onChanged: (value ) {
                                    setState(() {
                                      _type = Type.transfert;
                                      type = 'transfert';
                                    }
                                    );
                                  },
                                ),
                              ),
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
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    api.createCase(Transaction(type:type,montant: _montantController.text,descriptions: _descriptionsController.text,day:'',id: ''));
                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                   content: Text("add successful"),
                               ));
                                    Navigator.pop(context) ;
                                  }
                                },
                 child: Text('Save', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}