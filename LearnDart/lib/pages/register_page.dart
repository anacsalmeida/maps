import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_dart/controllers/controllers_login.dart';
import 'package:learning_dart/controllers/controllers_page.dart';

//splash screan

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ControllerCadastroPage controllerCadastro = new ControllerCadastroPage();
  ControllerLoginPage controllerLogin = new ControllerLoginPage();

  final _formKey = GlobalKey<FormState>();

  void updatedState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controllerCadastro.updateState = updatedState;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Cadastro'),
          backgroundColor: Color.fromARGB(255, 24, 24, 24)),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: size.height * 0.04),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.08,
                    right: size.width * 0.08,
                    bottom: size.height * 0.03),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    width: 3,
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  height: size.height * 0.18,
                  width: size.width * 0.45,
                  child: controllerCadastro.file == null
                      ? Container(
                          child:
                              const Center(child: Text('Selecione uma Imagem')),
                        )
                      : Image.file(
                          File(controllerCadastro.file!.path),
                          frameBuilder: (context, child, integer, value) {
                            if (integer == null) {
                              return const Center(
                                  child: SizedBox(
                                      height: 45,
                                      child: CircularProgressIndicator()));
                            } else {
                              return Image.file(
                                  File(controllerCadastro.file!.path));
                            }
                          },
                        ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.12,
                    right: size.width * 0.12,
                    bottom: size.height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          controllerCadastro.getImage(ImageSource.gallery);
                          setState(() {});
                        },
                        icon: const Icon(Icons.image)),
                    IconButton(
                        onPressed: () async {
                          await controllerCadastro.getImage(ImageSource.camera);
                          setState(() {});
                        },
                        icon: const Icon(Icons.camera))
                  ],
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
                  controller: controllerCadastro.displayName,
                  decoration: const InputDecoration(
                      hintText: 'Nome',
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
                  controller: controllerCadastro.userEmail,
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
                  controller: controllerCadastro.password,
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
                      // showToast('Usuário não cadastrado!');
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
                  controller: controllerCadastro.confirmedPassword,
                  // obscureText: controller.hiddenPassword,
                  decoration: const InputDecoration(
                      hintText: 'Confirme sua senha',
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
                      // showToast('Usuário não cadastrado!');
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
                        child: const Text('Cadastrar'),
                        onPressed: () async {
                          if (controllerCadastro.password.text ==
                              controllerCadastro.confirmedPassword.text) {
                            if (_formKey.currentState!.validate()) {
                              await controllerCadastro.contextBody(context);
                              controllerCadastro.clearRegister();
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Digite senhas iguais",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP_RIGHT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.teal,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 24, 24, 24),
                            textStyle: TextStyle(fontSize: 25))),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
