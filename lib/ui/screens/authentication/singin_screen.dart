import 'package:flutter/material.dart';
import 'package:roll_a_dice/services/authentication/google_authentication.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({Key? key}) : super(key: key);

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {

  login() async{
    await Future.delayed(Duration(seconds: 3));
    LoginWithGoogle().signIn();

  }
  @override
  void initState() {
    super.initState();
    login();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('data')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
