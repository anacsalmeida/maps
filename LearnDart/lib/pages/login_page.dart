import 'package:flutter/material.dart';
import 'package:learning_dart/controllers/controllers_login.dart';
import 'package:learning_dart/controllers/controllers_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

//splash screan

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ControllerCadastroPage controllerCadastro = new ControllerCadastroPage();
  ControllerLoginPage controllerLogin = new ControllerLoginPage();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void showToast(String msgErr) {
    Fluttertoast.showToast(
      msg: msgErr,
      fontSize: 15,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Conecte-se'),
          backgroundColor: Color.fromARGB(255, 24, 24, 24)),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: size.height * 0.04),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.40,
                  child: Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/imagens/user.png'),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.08,
                          right: size.width * 0.08,
                          bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                          width: 3,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: controllerLogin.emailLogin,
                        decoration: const InputDecoration(
                            hintText: 'E-mail',
                            fillColor: Colors.black,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite algum texto';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.08,
                          right: size.width * 0.08,
                          bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                          width: 3,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: controllerLogin.passwordLogin,
                        decoration: const InputDecoration(
                            hintText: 'Senha',
                            fillColor: Colors.black,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite algum texto';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: SizedBox(
                          width: 220.0,
                          height: 45.0,
                          child: ElevatedButton(
                              child: const Text('Entrar'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller:
                                  controllerLogin.userLogin(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 24, 24, 24),
                                  textStyle: TextStyle(fontSize: 25))),
                        ),
                      ),
                    ),
                  ]),
                )
              ]),
        ),
      ),
    );
  }
}
