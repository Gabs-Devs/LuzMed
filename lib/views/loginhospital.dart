import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luzmed/views/SignInHospital.dart';
import 'package:luzmed/views/widgets/btn.dart';
import 'package:luzmed/views/widgets/inputEmail.dart';
import 'package:luzmed/views/widgets/inputPswrd.dart';
import 'forget_password.dart';
import 'home_page.dart';

class LoginHospital extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _loginUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Error: $e');
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
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(94, 110, 165, 50),
            ),
            child: const Center(
              child: Text(
                "LuzMed",
                style: TextStyle(
                    fontSize: 38, color: Color.fromRGBO(234, 239, 255, 20)),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
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
                      Text(
                        "Entre na sua conta do seu hospital!",
                        style: TextStyle(
                            fontSize: 38,
                            color: Color.fromRGBO(94, 110, 165, 50),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      InputWidgetEmail(
                        controller: emailController,
                        emailLabelText: "Email",
                        emailHintText: "Coloque seu email",
                      ),
                      const SizedBox(height: 30),
                      InputWidgetPswrd(
                        controller: passwordController,
                        passwordLabelText: "Senha",
                        passwordHintText: "Coloque sua senha",
                      ),
                      const SizedBox(height: 16.0),
                      AnimatedButton(
                        buttonText: 'Login',
                        onPressed: () => _loginUser(context),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Não tem uma conta? ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(94, 110, 165, 50)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInHospital()));
                            },
                            child: const Text(
                              "Crie uma!",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(94, 110, 165, 50),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPage()));
                        },
                        child: const Text(
                          "Esqueci minha senha",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(94, 110, 165, 50),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
