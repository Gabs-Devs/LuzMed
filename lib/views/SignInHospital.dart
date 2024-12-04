import 'package:flutter/material.dart';
import 'package:luzmed/views/home_page.dart';
import 'package:luzmed/views/home_page_hospital.dart';
import 'package:luzmed/views/loginhospital.dart';
import 'package:luzmed/views/widgets/btn.dart';
import 'package:luzmed/views/widgets/inputEmail.dart';
import 'package:luzmed/views/widgets/inputPswrd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInHospital extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        cnpjController.text.isEmpty) {
      _showSnackBar(context, "Por favor, preencha todos os campos.");
      return;
    }

    if (passwordController.text.length < 6) {
      _showSnackBar(context, "A senha deve ter pelo menos 6 caracteres.");
      return;
    }

    String email = emailController.text;
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
      _showSnackBar(context, "Por favor, insira um email válido.");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwordController.text,
      );

      await FirebaseFirestore.instance.collection('hospital').doc(userCredential.user!.uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'cnpj': cnpjController.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageHospital()),
      );
    } catch (e) {
      _showSnackBar(context, "Erro: ${e is FirebaseAuthException ? e.message : e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(94, 110, 165, 4),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(94, 110, 165, 50),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(234, 239, 255, 20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(64),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Crie sua conta",
                        style: TextStyle(
                            fontSize: 38,
                            color: Color.fromRGBO(94, 110, 165, 50),
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          InputWidgetEmail(
                            emailLabelText: "Nome",
                            emailHintText: "Seu nome de usuario",
                            controller: nameController,
                          ),
                          const SizedBox(height: 30),
                          InputWidgetEmail(
                            emailLabelText: "Email",
                            emailHintText: "Email@example.com",
                            controller: emailController,
                          ),
                          const SizedBox(height: 30),
                          InputWidgetPswrd(
                            passwordHintText: "Senha",
                            passwordLabelText: "Coloque sua senha",
                            controller: passwordController,
                          ),
                          const SizedBox(height: 30),
                          InputWidgetEmail(
                            emailHintText: "Insira aqui seu CNPJ",
                            emailLabelText: "CNPJ",
                            controller: cnpjController,
                          ),
                          const SizedBox(height: 40),
                          AnimatedButton(
                            buttonText: 'Registrar',
                            onPressed: () => _registerUser(context),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Já tem uma conta? ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(94, 110, 165, 50)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginHospital()));
                            },
                            child: const Text(
                              "Entre nela!",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(94, 110, 165, 50),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ))
        ],
      ),
    );
  }
}
