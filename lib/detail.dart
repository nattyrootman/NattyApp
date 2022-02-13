import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String url;
  final String id;
  final String title;

  const Album({
    required this.url,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      url: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Detail> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data Example'),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.title),
                          subtitle: Text(snapshot.data!.id),
                          leading: Image.network(snapshot.data!.url),
                        );
                      });

                  return Text("data error");

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )),
    );
  }
}
