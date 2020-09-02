import 'package:barber_don/Home.dart';
import 'package:barber_don/ResetPassword.dart';
import 'package:barber_don/Signup.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  String _useremail;

  String _userpassword;

  void FazerTeste(){

    print("Isto e _useremail");
    print(_useremail);

    print("Isto e _userpassword");
    print(_userpassword);
  }

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: (){
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
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Teste",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: FazerTeste,
              ),
            ),

            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xff1a0f00),
                    Colors.red
                  ],
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
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => Home()
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                    "Cadastre-se",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: (){
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
