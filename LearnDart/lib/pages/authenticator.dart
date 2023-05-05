import 'package:flutter/material.dart';
import 'package:learning_dart/controllers/controllers_login.dart';
import 'package:learning_dart/controllers/controllers_page.dart';
import 'package:learning_dart/pages/login_page.dart';
import 'package:learning_dart/pages/register_page.dart';

class Authenticator extends StatefulWidget {
  const Authenticator({Key? key}) : super(key: key);

  @override
  State<Authenticator> createState() => _AuthenticatorState();
}

class _AuthenticatorState extends State<Authenticator> {
  ControllerCadastroPage controllerCadastro = new ControllerCadastroPage();
  ControllerLoginPage controllerLogin = new ControllerLoginPage();

  void updatedState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updatedState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: size.height,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: size.height * 0.40,
                  child: Center(
                    child: Container(
                      height: 220,
                      width: 220,
                      child: Image.asset('assets/imagens/mapa.png'),
                    ),
                  ),
                ),
                Container(
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Vamos começar?",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.40,
                  width: size.width * 0.8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // height: size.height * 0.40,
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 220.0,
                            height: 40.0,
                            child: ElevatedButton(
                                child: const Text('Entrar'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 24, 24, 24),
                                  textStyle: TextStyle(fontSize: 25),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 220.0,
                          height: 40.0,
                          child: ElevatedButton(
                              child: const Text('Cadastre-se'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 24, 24, 24),
                                  textStyle: TextStyle(fontSize: 25))),
                        ),
                      ]),
                )
              ]),
        ),
      ),
    );
  }
}
