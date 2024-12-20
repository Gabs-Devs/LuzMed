import 'package:flutter/material.dart';
import 'package:luzmed/views/home_page.dart';
import 'package:luzmed/views/widgets/btn.dart';
import 'package:luzmed/views/widgets/inputEmail.dart';
import 'package:luzmed/views/widgets/inputPswrd.dart';
import './login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController crmController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _registerUser (BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        crmController.text.isEmpty ||
        jobController.text.isEmpty) {
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

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text,
        'email': email,
        'CRM': crmController.text,
        'Especialidade': jobController.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          _showSnackBar(context, "Este email já está em uso.");
        } else {
          _showSnackBar(context, "Erro: ${e.message}");
        }
      } else {
        _showSnackBar(context, "Erro: $e");
      }
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
                            emailHintText: "CRM/EX 123456",
                            emailLabelText: "CRM",
                            controller: crmController,
                          ),
                          const SizedBox (height: 30),
                          InputWidgetEmail(
                            emailLabelText: "Especialidade",
                            emailHintText: "Coloque sua especialidade",
                            controller: jobController,
                          ),
                          const SizedBox(height: 40),
                          AnimatedButton(
                            buttonText: 'Registrar',
                            onPressed: () => _registerUser (context),
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
                                      builder: (context) => Login()));
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