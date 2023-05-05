import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:learning_dart/controllers/controllers_login.dart';
import 'package:learning_dart/pages/authenticator.dart';
import 'package:learning_dart/controllers/controllers_page.dart';
import 'package:learning_dart/pages/map_page.dart';

//splash screan

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  ControllerCadastroPage controllerCadastro = new ControllerCadastroPage();
  ControllerLoginPage controllerLogin = new ControllerLoginPage();
  Widget initialScreean = Authenticator();

  void updatedState() {
    if (mounted) setState(() {});
  }

  void initState() {
    super.initState();
    verifyInitial();
  }

  verifyInitial() async {
    bool validator = await controllerLogin.verifyTokenUser();
    if (validator == true) {
      initialScreean = MapPage();
    }
    updatedState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset('assets/imagens/pino.png'),
        backgroundColor: Colors.black,
        nextScreen: initialScreean,
        splashIconSize: 250,
        duration: 350);
  }
}
