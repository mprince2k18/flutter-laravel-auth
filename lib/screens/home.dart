import 'dart:io';

import 'package:auth/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/constant.dart';
import '../services/user_service.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User? user;
  bool loading = true;

  void getUser() async {
    ApiResponse response = await getUserDetail();
    var tk = getToken();

    setState(() {
      user = response.data as User;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(32),
        children: [
          Text('Prince'),
          kTextButton('Login', () {
            setState(() {
              getUser();
            });
          }),
        ],
      ),
    );
  }
}
