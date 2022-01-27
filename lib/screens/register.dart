import 'package:flutter/material.dart';

import '../services/constant.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: ListView(
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
          kTextButton('Register', (){
            // function onPressed
            print('Register');
          }),
          const SizedBox(height: 10),
          kLoginRegisterHint("Already have have an account? ", 'Login', (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false);
          }),
        ],
      ),
    );
  }
}
