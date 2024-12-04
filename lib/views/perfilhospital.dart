import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:luzmed/views/home_page_hospital.dart';
import 'package:luzmed/views/search.dart';

class ProfileHospital extends StatefulWidget {
  const ProfileHospital({Key? key}) : super(key: key);

  @override
  State<ProfileHospital> createState() => _ProfileHospitalState();
}

class _ProfileHospitalState extends State<ProfileHospital> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('Usuário não está logado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil Hospital'),
        backgroundColor: Color.fromRGBO(94, 110, 165, 1),
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
                  MaterialPageRoute(builder: (context) => UserSearchScreen()),
                );
              }
              if (index == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePageHospital()));
              }
              if (index == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileHospital()));
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hospital')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var hospitalData = snapshot.data!;

          return ListView(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: Icon(
                    Icons.local_hospital,
                    size: 72,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 185, 161, 255),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome: ${hospitalData['name']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'E-mail: ${hospitalData['email']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'CNPJ: ${hospitalData['cnpj']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
