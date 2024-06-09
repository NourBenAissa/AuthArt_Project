import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_db_services.dart';

class SettingsPage extends StatefulWidget {
  //const Settings({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(onPressed: (){
          context.read<AuthDBServices>().signOut();
        },
            child: Text("Log Out")),
      ),
    );
  }
}
