//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/services/authentication.dart';
import 'package:social_media/services/firestore_service.dart';

class ProfilPage extends StatefulWidget {
  final String profileOwnerId;
  const ProfilPage({Key key, this.profileOwnerId}) : super(key: key);

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
      //It returns the user information according to the user id.
      body: FutureBuilder<Object>(
          future: FirestoreService().getClient(widget.profileOwnerId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [_profilDetails(snapshot.data)],
            );
          }),
    );
  }

  Widget _profilDetails(Client profilData) {
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
                backgroundImage: profilData.photoUrl.isNotEmpty
                    ? NetworkImage(profilData.photoUrl)
                    : AssetImage("assets/images/cookie_monster.png"),
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
          Text(
            profilData.clientName,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(profilData.about),
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
  Widget _followerCounters({String counterTitle, int conuterNo}) {
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
