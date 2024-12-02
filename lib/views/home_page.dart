import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser ;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 239, 255, 1),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(94, 110, 165, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Center(
              child: Text(
                "LuzMed",
                style: TextStyle(
                    fontSize: 38, color: Color.fromRGBO(234, 239, 255, 1)),
              ),
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
            future: user != null
                ? FirebaseFirestore.instance.collection('users').doc(user.uid).get()
                : Future.value(null),
            builder: (context, snapshot) {
              String welcomeMessage = "Bem-vindo, usuário";
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  welcomeMessage = 'Bem-vindo, DR. ${snapshot.data!['name'] ?? "usuário"}';
                } else if (snapshot.hasError) {
                  welcomeMessage = 'Erro ao carregar nome';
                }
              }
              return Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(120, 147, 239, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        welcomeMessage,
                        style: const TextStyle(
                            fontSize: 14.15,
                            color: Color.fromRGBO(234, 239, 255, 1)),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "O que deseja fazer hoje?",
                        style: TextStyle(
                            fontSize: 14.15,
                            color: Color.fromRGBO(234, 239, 255, 1)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(context, 'Card 1'),
                        _buildCard(context, 'Card 2'),
                        _buildCard(context, 'Card 3'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(context, 'Card 4'),
                        _buildCard(context, 'Card 5'),
                        _buildCard(context, 'Card 6'),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(94, 110, 165, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromRGBO(94, 110, 165, 1),
            color: Colors.white,
            activeColor: Colors.white,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Pesquisa',
              ),
              GButton(
                icon: Icons.person,
                text: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title) {
    return Card(
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.15,
        alignment: Alignment.center,
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}