import 'package:flutter/material.dart';

class Nave extends StatelessWidget {
  const Nave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: EdgeInsets.all(0),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Amed Bathily"),
            accountEmail: Text("abthily20@gmail.com"),
            currentAccountPicture: Image.network(
                "https://th.bing.com/th/id/OIP.2PWRGDPDdzCEVXM_56tD0gAAAA?w=286&h=180&c=7&r=0&o=5&pid=1.7"),
          ),
          ListTile(
            title: Text("Book"),
            leading: Icon(Icons.book),
          ),
          ListTile(
            title: Text("Music"),
            leading: Icon(Icons.music_note),
          ),
          ListTile(
            title: Text("Service"),
            leading: Icon(Icons.room_service),
          ),
          ListTile(
            title: Text("Contacts"),
            leading: Icon(Icons.contact_phone),
          ),
        ],
      ),
    ));
  }
}
