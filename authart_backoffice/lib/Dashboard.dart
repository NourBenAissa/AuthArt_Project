// @dart=2.9

import 'package:authart_backoffice/artists_page.dart';
import 'package:authart_backoffice/artworks_page.dart';
import 'package:authart_backoffice/messages.dart';
import 'package:authart_backoffice/profile_page.dart';
import 'package:authart_backoffice/settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Widgets/dashboard_screen.dart';
class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var userData = {};
  int index = 0;

  PageController page = PageController();

  @override
  void initState() {
    getData();
  }
  getData() async{
    var userSnap = await FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      userData=userSnap.data();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.blueAccent.shade100,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: const Icon(Icons.home),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Artists',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Artworks',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: const Icon(Icons.file_copy_rounded),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Moderators',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: const Icon(Icons.supervised_user_circle)
                ,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Profile',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: const Icon(Icons.person),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Settings',
                onTap: () async {
                  page.jumpToPage(5);
                },
                icon: const Icon(Icons.settings_outlined, color: Colors.black,),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                DashboardScreen(),
                ArtistsPage(),
                ArtworksPage(),
                Chat(),
                ProfilePage(),
                SettingsPage(),
              ],
            ),
          ),
        ],
      ),
    );
      /*Scaffold(
      extendBody: true,
      body: screens[index],
      drawer: Drawer(

        child: ListView(
          children: [
            DrawerHeader(child: Image.asset("assets/images/logo.png"),),
            ListTile(
              onTap: () {
                setState(() => this.index = 0);

              },
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.dashboard, color: Colors.black,size: 16,),
              title: Text("Dashboard",
                  style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () {
                setState(() => this.index = 1);

              },
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.supervised_user_circle, color: Colors.black,size: 16,),
              title: Text("Artists",
                  style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () {
                setState(() => this.index = 2);

              },
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.file_copy_outlined, color: Colors.black,size: 16,),
              title: Text("Artworks",
                  style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () {
                setState(() => this.index = 3);

              },
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.chat_bubble_outline, color: Colors.black,size: 16,),
              title: Text("Messages",
                  style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () {
                setState(() => this.index = 4);

              },
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.person, color: Colors.black,size: 16,),
              title: Text("Profile",
                  style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              onTap: () {
                setState(() => this.index = 5);
              },
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.settings_outlined, color: Colors.black,size: 16,),
              title: Text("Settings",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),

      ),

    );*/
      /*Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );*/
  }
}
