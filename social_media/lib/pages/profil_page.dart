import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/services/authentication.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
        actions: [
          IconButton(
            onPressed: _exitApp,
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        children: [_profilDetails()],
      ),
    );
  }

  Widget _profilDetails() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _followerCounters(
                        counterTitle: "Gönderiler", conuterNo: 35),
                    _followerCounters(counterTitle: "Takipçi", conuterNo: 384),
                    _followerCounters(counterTitle: "Takip", conuterNo: 402),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Kullanıcı Adı",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          const Text("Hakkında"),
          const SizedBox(height: 25.0),
          _profilEditButton(),
        ],
      ),
    );
  }

  Widget _profilEditButton() {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text(
          "Profili Düzenle",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

//Settings for follower counters.
  Widget _followerCounters(
      {required String counterTitle, required int conuterNo}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          conuterNo.toString(),
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          counterTitle,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }

  void _exitApp() {
    Provider.of<Authentication>(context, listen: false).signOut();
  }
}
