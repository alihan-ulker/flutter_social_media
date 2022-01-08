import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/pages/explore_page.dart';
import 'package:social_media/pages/flow_page.dart';
import 'package:social_media/pages/notification_page.dart';
import 'package:social_media/pages/profil_page.dart';
import 'package:social_media/pages/upload_page.dart';
import 'package:social_media/services/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageNo = 0;
  late PageController pageControl;

  @override
  void initState() {
    super.initState();
    pageControl = PageController();
  }

//Close the controller that is no longer needed when exiting the page.
  @override
  void dispose() {
    pageControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String activeClientId =
        Provider.of<Authentication>(context, listen: false).activeClientId;

    return Scaffold(
      body: PageView(
        //Turns off page switching by scrolling.
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (openedPageNo) {
          setState(() {
            _selectedPageNo = openedPageNo;
          });
        },
        controller: pageControl,
        children: [
          FlowPage(),
          ExplorePage(),
          UploadPage(),
          NotificationPage(),
          ProfilPage(
            profileOwnerId: activeClientId,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageNo,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Akış"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Keşfet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload), label: "Yükle"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Duyurular"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        onTap: (selectedPageNo) {
          setState(() {
            pageControl.jumpToPage(selectedPageNo);
          });
        },
      ),
    );
  }
}
