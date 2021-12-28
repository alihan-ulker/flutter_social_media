import 'package:flutter/material.dart';
import 'package:social_media/services/authentication.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  late String userName, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Oluştur"),
      ),
      body: ListView(
        children: [
          loading
              ? const LinearProgressIndicator()
              : const SizedBox(
                  height: 0.0,
                ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    //Keyboard autocomplete.
                    autocorrect: true,
                    decoration: const InputDecoration(
                      hintText: "Kullanıcı adınızı giriniz.",
                      labelText: "Kullanıcı Adı:",
                      //Error message style
                      errorStyle: TextStyle(fontSize: 16.0),
                      //Adding an icon to the head.
                      prefixIcon: Icon(Icons.person),
                    ),

                    //Entered value check
                    validator: (inputValue) {
                      if (inputValue!.isEmpty) {
                        return "Kullanıcı adı boş bırakılamaz!";
                      } else if (inputValue.trim().length < 4 ||
                          inputValue.trim().length > 10) {
                        return "En az 4 en fazla 10 karakter olabilir!";
                      }
                      return null;
                    },
                    onSaved: (inputValue) => userName = inputValue!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    //Keyboard type is set to email.
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email adresinizi giriniz.",
                      labelText: "Mail:",
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
                    onSaved: (inputValue) => email = inputValue!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    //To hide the password.
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Şifrenizi giriniz.",
                      labelText: "Şifre:",
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
                    onSaved: (inputValue) => password = inputValue!,
                  ),
                  const SizedBox(height: 50.0),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _createUser,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createUser() async {
    var _formState = _formKey.currentState;

    if (_formState!.validate()) {
      _formState.save();
      setState(() {
        loading = true;
      });

      await Authentication().registerWithEmail(email, password);
      Navigator.pop(context);
    }
  }
}
