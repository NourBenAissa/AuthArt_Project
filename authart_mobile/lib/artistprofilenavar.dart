import 'package:another_project/sign_in_page.dart';
import 'package:another_project/update_artist_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticationService.dart';


class ArtistProfileNavbar extends StatelessWidget {
  const ArtistProfileNavbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        children: [

          ListTile(
            leading: Icon(Icons.create),
            title: Text('Update profile'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateArtistPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.upgrade),
            title: Text('Upgrade profile'),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){
             Settings();
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('log out'),
            onTap: (){
              context.read<AuthenticationService>().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
