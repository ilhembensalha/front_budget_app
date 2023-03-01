import 'package:flutter/material.dart';
import 'package:budget_app/models/transaction.dart';

import 'package:budget_app/models/utilisateur.dart';
import 'package:budget_app/services/api_trans.dart';
import 'package:budget_app/services/api_utli.dart';
import 'package:intl/intl.dart';


enum Type { revenu, depence,transfert }

class Edittrans extends StatefulWidget {
  Edittrans(this.transaction);

  final Transaction transaction;

  @override
  _EdittransState createState() => _EdittransState();
}

class _EdittransState extends State<Edittrans> {
  _EdittransState();

  final ApiTrans api = ApiTrans();
  final _addFormKey = GlobalKey<FormState>();
  String id = '';
  String day = '';
  final _montantController = TextEditingController();
  final _descriptionsController = TextEditingController();
  final _dateController = TextEditingController();
  String type = 'revenu';
  Type _type = Type.revenu;
 

  

  @override
  void initState() {
    id = widget.transaction.id;
    _montantController.text = widget.transaction.montant;
   _descriptionsController.text = widget.transaction.descriptions;
  _dateController.text = widget.transaction.day;
type = widget.transaction.type;
    if(widget.transaction.type == 'revenu') {
      _type = Type.revenu;
    } else if(widget.transaction.type == 'depence') {
      _type = Type.depence;
    } else {
      _type = Type.transfert;
    }
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit transaction'),
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
                                    return 'Please enter montant ';
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
               Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('date'),
                              TextFormField(
                                controller: _dateController,
                                decoration: const InputDecoration(
                                  hintText: 'date',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter date';
                                  }
                                  return null;
                                },
                                 //readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateController.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                         

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
                                    api.updateCases(id, Transaction(montant: _montantController.text,type: type ,descriptions: _descriptionsController.text ,day: _dateController.text , id: ''));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("update successful"),
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