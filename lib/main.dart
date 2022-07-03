//import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//qqqqqfff

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection("messages").snapshots(),
                builder: (context, snapshot) {
                  List<Text> messageWidgets = [];
                  if (snapshot.hasData) {
                    final messages = snapshot.data?.docs;

                    for (var msg in messages!) {
                      final messageText = msg.get("text");
                      final messageSender = msg.get("sender");
                      final messageWidget =
                          Text("$messageText from $messageSender");
                      messageWidgets.add(messageWidget);
                    }
                   
                    print("dsddd: $messages");
                     
                  }

                //return Text("fgfg");
                  
                  
                  return Column(
                    children:messageWidgets,
                  );
                  
                  
                  
                }),
            TextButton(
              onPressed: () async {
                await for (var snapshot
                    in firestore.collection("messages").snapshots()) {
                  for (var msg in snapshot.docs) {
                    print(msg.data());
                  }
                }
              },
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
