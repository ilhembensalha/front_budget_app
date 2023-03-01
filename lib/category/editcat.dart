import 'package:flutter/material.dart';
import 'package:budget_app/models/categories.dart';
import 'package:budget_app/services/api.dart';




class Editcat extends StatefulWidget {
  Editcat(this.categories);

  final Categories categories;

  @override
  _EditcatState createState() => _EditcatState();
}

class _EditcatState extends State<Editcat> {
  _EditcatState();

  final ApiServiceCat api = ApiServiceCat();
  final _addFormKey = GlobalKey<FormState>();
  String id = '';
  final _nameController = TextEditingController();
 
  

  @override
  void initState() {
    id = widget.categories.id;
    _nameController.text = widget.categories.nomcat;
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
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
                              Text('category'),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'category',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter category';
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
                                    api.updateCases(id, Categories(nomcat: _nameController.text, id: ''));
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