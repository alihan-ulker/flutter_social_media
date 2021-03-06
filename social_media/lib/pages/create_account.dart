//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/services/authentication.dart';
import 'package:social_media/services/firestore_service.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      if (inputValue.isEmpty) {
                        return "Kullanıcı adı boş bırakılamaz!";
                      } else if (inputValue.trim().length < 4 ||
                          inputValue.trim().length > 10) {
                        return "En az 4 en fazla 10 karakter olabilir!";
                      }
                      return null;
                    },
                    onSaved: (inputValue) => userName = inputValue,
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
                      if (inputValue.isEmpty) {
                        return "Email alanı boş bırakılamaz!";
                      } else if (!inputValue.contains("@")) {
                        return "Girilen değer mail formatında olmalıdır!";
                      }
                      return null;
                    },
                    onSaved: (inputValue) => email = inputValue,
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
                      if (inputValue.isEmpty) {
                        return "Şifre alanı boş bırakılamaz!";
                      } else if (inputValue.trim().length < 4) {
                        return "Şifre 4 karakterden daha az olamaz!";
                      }
                      return null;
                    },
                    onSaved: (inputValue) => password = inputValue,
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
    final _authenticationService =
        Provider.of<Authentication>(context, listen: false);
    var _formState = _formKey.currentState;

    if (_formState.validate()) {
      _formState.save();
      setState(() {
        loading = true;
      });

      try {
        Client client =
            await _authenticationService.registerWithEmail(email, password);
        if (client != null) {
          FirestoreService().createClient(
            id: client.id,
            email: client.email,
            clientName: client.clientName,
          );
        }
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          loading = false;
        });
        showAlert(errorCode: error.code);
      }
    }
  }

//Warnings shown according to the errors that occur.
  showAlert({errorCode}) {
    String errorMessage;

    if (errorCode == "invalid-email") {
      errorMessage = "Girdiğiniz mail adresi geçersizdir!";
    } else if (errorCode == "email-already-in-use") {
      errorMessage = "Girdiğiniz mail kullanılmaktadır!";
    } else if (errorCode == "weak-password") {
      errorMessage = "Daha zor bir şifre tercih edin!";
    }

    var snackBar = SnackBar(content: Text(errorMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
