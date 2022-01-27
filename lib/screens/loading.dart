import 'package:auth/models/api_response.dart';
import 'package:auth/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:auth/services/user_service.dart';

import 'login.dart';
import 'home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _loadUserInfo() async {
    String token = await getToken();
    if(token == ''){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false);
    }else{
      ApiResponse response = await getUserDetail();
      if( response.error == null ){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => false);
      }else if ( response.error == unauthorized ){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${response.error}')
        ));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.deepOrangeAccent,
        )
      ),
    );
  }
}
