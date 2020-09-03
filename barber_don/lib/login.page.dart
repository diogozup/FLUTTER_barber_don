import 'package:barber_don/Home.dart';
import 'package:barber_don/ResetPassword.dart';
import 'package:barber_don/Signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Facebook auth
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
//Facebook auth
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //!------------------------------------------ global vars
  String _useremail;
  String _userpassword;
  String _usernameFirst;
  String _usernameLast;
  String _username;
  bool userIsFacebookLogged = false;

  //!------------------------------------------ funcoes
  //*------------------------------------------ Firebase
  void _onPressed() {
    print("pressed");
    // ignore: deprecated_member_use
    final firestoreInstance = Firestore.instance;
    firestoreInstance.collection("users").add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      // ignore: deprecated_member_use
      print(value.documentID);
    });
  }

  //------------------------------------------- facebook start
  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result =
        await LoginPage.facebookSignIn.logIn(['email']);

    print("RESULT:" + result.toString());
    print("RESULT:" + result.status.toString());
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
    print(graphResponse.body);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print("****************** ENTROU PELO FACEBOOK ***************");
        String facebookUserData = graphResponse.body;
        final body = json.decode(facebookUserData);
        _username = body['name'];
        _usernameFirst = body['first_name'];
        _usernameLast = body['last_name'];
        print("Nome Completo: " + _username);
        print("Primeiro Nome: " + _usernameFirst);
        print("Último Nome: " + _usernameLast);

        // GRAVAR AQUI NO FIREBASE O CLIENTE QUE LOGGOU PELO FACEBOOK

        setState(() {
          userIsFacebookLogged = true;
        });

        break;
      case FacebookLoginStatus.cancelledByUser:
        print("****************** CANCELED FACEBOOK ***************");
        break;
      case FacebookLoginStatus.error:
        print("****************** ERROR FACEBOOK ***************");
        print('Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await LoginPage.facebookSignIn.logOut();
    print("****************** SAIU DO FACEBOOK ***************");
    setState(() {
      userIsFacebookLogged = false;
    });
  }

  //------------------------------------------- facebook end
  void _goToScreenHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    // void _goToScreenHome(){
    //     Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Home()),
    // );
  }

  void FazerTeste() {
    print("Isto e _useremail");
    print(_useremail);
    print("Isto e _userpassword");
    print(_userpassword);
    _onPressed();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 100,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("image/logo_1.jpg"),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => _useremail = value,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) => _userpassword = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPassword(),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 20,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Teste",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: FazerTeste,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [Color(0xff1a0f00), Colors.red],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [Colors.black, Colors.blue],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (userIsFacebookLogged == false)
                        ? <Widget>[
                            Text(
                              "Login com Facebook",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ]
                        : <Widget>[
                            Text(
                              "Logout do Facebook",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                  ),
                  onPressed: (userIsFacebookLogged == false) ? _login : _logOut,
                ),
              ),
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
