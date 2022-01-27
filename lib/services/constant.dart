// -------------- STRINGS ------------------
import 'package:flutter/material.dart';

const baseURL = 'http://10.0.2.2:8000/api/';
const loginURL = baseURL + 'login';
const registerURL = baseURL + 'register';
const logoutURL = baseURL + 'logout';
const userURL = baseURL + 'user';

// -------------- ERRORS -------------------
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong. try again.';

// ------------ INPUT DECORATION -----------
InputDecoration kInputDecoration(String lable){
  return InputDecoration(
      labelText: lable,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: Colors.black
          )
      )
  );
}

// ------------ BUTTON -----------
TextButton kTextButton(String lable, Function onPressed){
  return TextButton(
    onPressed: () => onPressed (),
    child: Text(lable,
      style: const TextStyle(
          color: Colors.white
      ),
    ),
    style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10))
    ),

  );
}

// ------------ ROW -----------
Row kLoginRegisterHint(String text, String lable, Function onTap){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          lable,
          style: const TextStyle(color: Colors.blue),
        ),
        onTap: () => onTap(),
      ),
    ],
  );
}

// ---- LOADER -----

class DataLoader extends StatelessWidget {
  const DataLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrangeAccent,
          )),
    );
  }
}
