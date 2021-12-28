import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 60.0,
        ),
        children: [
          const FlutterLogo(
            size: 90.0,
          ),
          const SizedBox(
            height: 80.0,
          ),
          TextFormField(
            //Keyboard autocomplete.
            autocorrect: true,
            //Keyboard type is set to email.
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email adresinizi giriniz.",
              //Adding an icon to the head.
              prefixIcon: Icon(Icons.mail),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextFormField(
            //To hide the password.
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Şifrenizi giriniz.",
              //Adding an icon to the head.
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Hesap Oluştur",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Giriş Yap",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
