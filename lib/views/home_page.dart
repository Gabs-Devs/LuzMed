import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:luzmed/views/extras.dart';
import 'package:luzmed/views/perfil.dart';
import 'package:luzmed/views/searchhospital.dart';

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
    final User? user = FirebaseAuth.instance.currentUser;

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
                ? FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get()
                : Future.value(null),
            builder: (context, snapshot) {
              String welcomeMessage = "Bem-vindo, usuário";
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  welcomeMessage =
                      'Bem-vindo, DR. ${snapshot.data!['name'] ?? "usuário"}';
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
                        _buildCard(context, 'Noticias'),
                        _buildCard(context, 'Principais demandas'),
                        _buildCard(context, 'FAQ'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(context, 'Perfil'),
                        _buildCard(context, 'Hospitais'),
                        _buildCard(context, 'Detalhes sobre o app'),
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
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HospitalSearchScreen()),
                );
              }
              if (index == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
              if (index == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileMedico()));
              }
            },
            tabBackgroundColor: Color.fromRGBO(120, 147, 239, 1),
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
    return GestureDetector(
      onTap: () {
        Widget page;
        switch (title) {
          case 'Noticias':
            page = const NoticiasScreen();
            break;
          case 'Principais demandas':
            page = const PrincipaisDemandasScreen();
            break;
          case 'FAQ':
            page = const FAQScreen();
            break;
          case 'Perfil':
            page = ProfileMedico();
            break;
          case 'Hospitais':
            page = HospitalSearchScreen();
            break;
          case 'Detalhes sobre o app':
            page = const DetalhesAppScreen();
            break;
          default:
            page = const Placeholder();
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 4,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.15,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromRGBO(94, 110, 165, 1),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
