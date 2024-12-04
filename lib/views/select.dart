import 'package:flutter/material.dart';
import 'package:luzmed/views/SignIn.dart';
import 'package:luzmed/views/SignInHospital.dart';
import 'package:luzmed/views/widgets/btn.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(94, 110, 165, 1),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(94, 110, 165, 1),
            ),
            child: const Center(
              child: Text(
                "LuzMed",
                style: TextStyle(
                    fontSize: 38, color: Color.fromRGBO(234, 239, 255, 1)),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width ,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(234, 239, 255, 1),
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
                        "Bem vindo!",
                        style: TextStyle(
                          fontSize: 38,
                          color: Color.fromRGBO(94, 110, 165, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Você é",
                        style: TextStyle(
                          fontSize: 23.48,
                          color: Color.fromRGBO(94, 110, 165, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                      AnimatedButton(
                        buttonText: 'Médico',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                      AnimatedButton(
                        buttonText: 'Hospital',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInHospital()),
                          );
                        },
                      ),
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