import 'package:another_project/chat_page.dart';
import 'package:another_project/favorite_page.dart';
import 'package:another_project/settings.dart';
import 'package:another_project/sign_up_artist_page.dart';
import 'package:another_project/sign_up_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Qr_scan_page.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 2;
  final screens = [
    chatPage(),
    qrScanPage(),
    Dashboard(),
    favoritePage(),
    settingsPage(),
  ];
  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      Icon(Icons.chat_bubble_outline, size:30),
      Icon(Icons.qr_code_2_outlined, size:30),
      Icon(Icons.home_outlined, size:30),
      Icon(Icons.favorite_outline, size:30),
      Icon(Icons.settings_outlined, size:30),

    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar:
      Theme(
        data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.black)),

        child: CurvedNavigationBar(

          color: Colors.white,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.blueAccent.shade100,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          index: index,
          items: items,
          onTap:(index) => setState(() => this.index = index) ,
        ),
      ),
    );

  }
}

