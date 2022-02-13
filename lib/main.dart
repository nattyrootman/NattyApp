// ignore_for_file: dead_code, prefer_const_literals_to_create_immutables, prefer_const_constructors, empty_statements

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail.dart';
import 'package:flutter_application_1/nave.dart';
import 'package:flutter_application_1/sign_up.dart';
import 'package:flutter_application_1/util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constant.prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Constant.prefs!.getBool("key") == true ? MyHomePage() : Sign(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Sign.routName: (context) => Sign(),
        MyHomePage.routName: (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String routName = "/home";
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url = "https://jsonplaceholder.typicode.com/photos";
  var data;

  var itemBuilder;

  Future _fetch() async {
    var ti = await http.get(Uri.parse(url));

    data = jsonDecode(ti.body);

    return data;
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text("Page d'accueil"),
        centerTitle: true,
        actions: [
          // ignore: prefer_const_constructors
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Constant.prefs!.setBool("key", false);
              Navigator.pushReplacementNamed(context, Sign.routName);
            },
          ),
        ],
      ),
      drawer: Nave(),
      body: FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("fetch something"),
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(" something went wrong"),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]["title"]),
                    subtitle: Text("Id:${data[index]["id"]}"),
                    leading: Image.network(data[index]["url"]),
                  );
                },
              );

              ;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.send),
      ),
    );
  }
}
