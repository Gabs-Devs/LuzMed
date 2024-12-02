
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class select_screen extends StatefulWidget {
  const select_screen({super.key});

  @override
  State<select_screen> createState() => _select_screenState();
}

class _select_screenState extends State<select_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(94, 110, 165, 4),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
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
                topRight: Radius.circular(64)
              ),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                      Text(
                        "Bem vindo!",
                        style: TextStyle(
                            fontSize: 38,
                            color: Color.fromRGBO(94, 110, 165, 50),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Você é",
                        style: TextStyle(
                            fontSize: 23.48,
                            color: Color.fromRGBO(94, 110, 165, 50),
                            fontWeight: FontWeight.bold),
                      ),
                      
                  ],
                ),
              )
            ),
            )
          )
        ],
      ),
    );
  }
}