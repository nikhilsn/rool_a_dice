import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/services/authentication/google_authentication.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({Key? key}) : super(key: key);

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  _login() async {
    await Future.delayed(Duration(seconds: 3));
    LoginWithGoogle().signIn();
  }

  Widget _imageWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/dice1.png',
          scale: 0.9,
        ),
        Image.asset(
          'assets/dice3.png',
          scale: 0.9,
        ),
        Image.asset(
          'assets/dice5.png',
          scale: 0.9,
        ),
        Image.asset(
          'assets/dice6.png',
          scale: 0.9,
        ),
      ],
    );
  }

  Widget _signinWithGoogleButton() {
    return SignInButton(
      Buttons.Google,
      onPressed: _login,
    );
  }

  @override
  void initState() {
    super.initState();
    // login();
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
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Constants.appName,
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _imageWidget(),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: _signinWithGoogleButton(),
                ),
                Expanded(child: Container())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
