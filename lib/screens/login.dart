import 'dart:io';

import 'package:auth/models/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/constant.dart';
import '../services/user_service.dart';
import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);

    if (txtEmail.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email field is required.'),
        ),
      );
      return null;
    }

    if (txtPassword.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password field is required.'),
        ),
      );
      return null;
    }

    // check user exists
    if (response.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have entered an invalid email or password'),
        ),
      );
      return null;
    }
    // login user
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      // server error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}')),
      );
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://i.pinimg.com/originals/68/f1/4a/68f14a7d775b6ff4a0324b712074be25.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(32),
            children: [
              TextFormField(
                key: formkey,
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                decoration: kInputDecoration("Email"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtPassword,
                obscureText: true,
                validator: (val) =>
                    val!.isEmpty ? 'Required at least 8 characters' : null,
                decoration: kInputDecoration("Password"),
              ),
              const SizedBox(height: 10),
              kTextButton('Login', () {
                setState(() {
                  loading = true;
                  _loginUser();
                });
              }),
              const SizedBox(height: 10),
              kLoginRegisterHint("Don't have an account? ", 'Register', () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Register()),
                    (route) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
