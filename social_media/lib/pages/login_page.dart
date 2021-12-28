import 'package:flutter/material.dart';
import 'package:social_media/pages/create_account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pageElements(),
          _loadingAnimation(),
        ],
      ),
    );
  }

  _loadingAnimation() {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center();
    }
  }

  Widget _pageElements() {
    return Form(
      key: _formKey,
      child: ListView(
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
              //Error message style
              errorStyle: TextStyle(fontSize: 16.0),
              //Adding an icon to the head.
              prefixIcon: Icon(Icons.mail),
            ),

            //Entered value check
            validator: (inputValue) {
              if (inputValue!.isEmpty) {
                return "Email alanı boş bırakılamaz!";
              } else if (!inputValue.contains("@")) {
                return "Girilen değer mail formatında olmalıdır!";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextFormField(
            //To hide the password.
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Şifrenizi giriniz.",
              //Error message style
              errorStyle: TextStyle(fontSize: 16.0),
              //Adding an icon to the head.
              prefixIcon: Icon(Icons.lock),
            ),

            //Entered value check
            validator: (inputValue) {
              if (inputValue!.isEmpty) {
                return "Şifre alanı boş bırakılamaz!";
              } else if (inputValue.trim().length < 4) {
                return "Şifre 4 karakterden daha az olamaz!";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 70.0,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ),
                    );
                  },
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
                  onPressed: _login,
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
          const SizedBox(height: 20.0),
          const Center(child: Text("veya")),
          const SizedBox(height: 20.0),
          const Center(
              child: Text(
            "Google ile Giriş Yap",
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          )),
          const SizedBox(height: 20.0),
          const Center(child: Text("Şifremi Unuttum")),
        ],
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
    }
  }
}
