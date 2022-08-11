//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/pages/create_account.dart';
import 'package:social_media/services/authentication.dart';
import 'package:social_media/services/firestore_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              if (inputValue.isEmpty) {
                return "Email alanı boş bırakılamaz!";
              }
              //Checking the @ sign in the mail address
              else if (!inputValue.contains("@")) {
                return "Girilen değer mail formatında olmalıdır!";
              }
              return null;
            },
            onSaved: (inputValue) => email = inputValue,
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
              if (inputValue.isEmpty) {
                return "Şifre alanı boş bırakılamaz!";
              } else if (inputValue.trim().length < 4) {
                return "Şifre 4 karakterden daha az olamaz!";
              }
              return null;
            },
            onSaved: (inputValue) => password = inputValue,
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
          Center(
              child: InkWell(
            onTap: _loginWithGoogle,
            child: const Text(
              "Google ile Giriş Yap",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          )),
          const SizedBox(height: 20.0),
          const Center(child: Text("Şifremi Unuttum")),
        ],
      ),
    );
  }

//Firebase login services
  void _login() async {
    final _authenticationService =
        Provider.of<Authentication>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState?.save();
      setState(() {
        loading = true;
      });

//Sign in with Email
      try {
        await _authenticationService.loginWithEmail(email, password);
      } catch (error) {
        setState(() {
          loading = false;
        });

        showAlert(errorCode: error.code);
      }
    }
  }

//Google login settings
  void _loginWithGoogle() async {
    var _authenticationService =
        Provider.of<Authentication>(context, listen: false);

    setState(() {
      loading = true;
    });

    try {
      Client client = await _authenticationService.loginWithGoogle();
      if (client != null) {
        Client firestoreClient = await FirestoreService().getClient(client.id);
        if (firestoreClient == null) {
          FirestoreService().createClient(
            id: client.id,
            email: client.email,
            password: client.password,
            clientName: client.clientName,
            photoUrl: client.photoUrl,
          );
        }
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      showAlert(errorCode: error.code);
    }
  }

//Warnings shown according to the errors that occur.
  showAlert({errorCode}) {
    String errorMessage;

    if (errorCode == "invalid-email") {
      errorMessage = "Girdiğiniz mail adresi geçersizdir!";
    } else if (errorCode == "user-disabled") {
      errorMessage = "Kullanıcı engellenmiştir!";
    } else if (errorCode == "user-not-found") {
      errorMessage = "Böyle bir kullanıcı bulunamadı!";
    } else if (errorCode == "wrong-password") {
      errorMessage = "Girdiğiniz şifre hatalıdır!";
    } else {
      errorMessage = "Tanımlanamayan bir hata oluştu $errorCode";
    }
    var snackBar = SnackBar(content: Text(errorMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
