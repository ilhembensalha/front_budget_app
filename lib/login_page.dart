import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/widgets/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'common/theme_helper.dart';
import 'registration_page.dart';
import '../widgets/header_widget.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

final _emailController=TextEditingController();
final _passwordController=TextEditingController();

    Future save(String email,String password ) async {
    var res = await http.post(Uri.parse('http://192.168.1.31:3000/api/utilisateur/login'), 
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': email,
          'password': password
        });
    print(res.body);
    
    if (res.statusCode ==200){
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Nav()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("login successful"),
    ));
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'login',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                    key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                controller: _emailController,
                                decoration: ThemeHelper().textInputDecoration('User email', 'Enter your user name'),
                               
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                            
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),


                            Container(
                             margin: EdgeInsets.fromLTRB(5,20,10,20),
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: () {
                         
                            save(_emailController.text,_passwordController.text);
                          
                        },
                                   
                              ),
                        
                            ),
                          
                            Container(
                              margin: EdgeInsets.fromLTRB(5,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}