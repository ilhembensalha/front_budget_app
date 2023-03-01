import 'package:flutter/material.dart';
import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/transaction/detailstrans.dart';





class TransactionList extends StatelessWidget {

  final List<Transaction> transaction ;
  TransactionList({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: transaction == null ? 0 : transaction.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detailstrans(transaction[index])),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.attach_money_outlined),
                      title: Text(transaction[index].type + ':'+transaction[index].montant),
                      subtitle:Text('a '+transaction[index].day) ,
                     
                    ),
                  )
              );
          });
  }

}