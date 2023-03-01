import 'package:flutter/material.dart';
import 'package:budget_app/category/afiichecat.dart';
import 'package:budget_app/category/editcat.dart';
import 'package:budget_app/models/categories.dart';
import 'package:budget_app/services/api.dart';



class Detailscat extends StatefulWidget {
  Detailscat(this.categories);

  final Categories categories;

  @override
  _DetailscatState createState() => _DetailscatState();
}

class _DetailscatState extends State<Detailscat> {
  _DetailscatState();

  final ApiServiceCat api = ApiServiceCat();

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
             clipBehavior: Clip.antiAlias,
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Name:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                            Text(widget.categories.nomcat, style: Theme.of(context).textTheme.headline6)
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
                                _navigateToEditScreen(context, widget.categories);
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

  _navigateToEditScreen (BuildContext context, Categories categories) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Editcat(categories)),
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
                api.deleteCase(widget.categories.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("delete successful"),
    ));
                  Navigator.pop(context) ;
              
              },
          ),              TextButton(
            child: Text(
              'no',
            ), 
          style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: Colors.blue)),
             onPressed: () {
                Navigator.of(context).pop();
              },
          )
          ],
        );
      },
    );
  }

}