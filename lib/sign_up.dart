// ignore_for_file: prefer_const_constructors

// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/constants.dart';

class Sign extends StatefulWidget {
  static String routName = "/sign";
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final formeKy = GlobalKey<FormState>();

  final userName = TextEditingController();

  final passWord = TextEditingController();

  String test = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://media.gettyimages.com/photos/farmers-harvesting-vegetables-at-farm-against-sky-picture-id1250941301?k=20&m=1250941301&s=612x612&w=0&h=SzmGqS2NZ_Woa4qNuNmTHVejgc10gng0UauY2sAdehM=",
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.dstOver,
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                  key: formeKy,
                  child: Card(
                    color: Colors.lightGreen[50],
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your name";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                labelText: "Nom",
                                hintText: "Votre Nom",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16))),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passWord,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your password";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: "Mot de Passe",
                              hintText: "Votre Mot de Passe",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Constant.prefs!.setBool("key", true);
                                if (formeKy.currentState!.validate()) {
                                  Navigator.pushNamed(
                                      context, MyHomePage.routName);
                                }
                              },
                              child: Text("Inscrivez-Vous",
                                  style: TextStyle(color: Colors.black)))
                        ],
                      ),
                    ),
                  )),
            ),
          )),
        ],
      ),
    );
  }
}
