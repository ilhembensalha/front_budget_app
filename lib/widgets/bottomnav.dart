import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budget_app/pages/options.dart';

import 'package:budget_app/transaction/affichetrans.dart';
import 'package:budget_app/widgets/navigation_drawer_widget.dart' as drawer;


class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
   
      Affichetrans(title: '',),  
      MyApp(), 
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: const drawer.NavigationDrawer(),
      appBar: AppBar(
        title: Text('budget app'),
      ),
      

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money_outlined ,
               color:Colors.black,
            ),
            label: 'trans',
          ),
        
           BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color:Colors.black,
            ),
            label: 
              'options',
             
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}