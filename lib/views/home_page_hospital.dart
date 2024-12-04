import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:luzmed/views/extras.dart';
import 'package:luzmed/views/perfilhospital.dart';
import 'package:luzmed/views/search.dart';

class HomePageHospital extends StatefulWidget {
  const HomePageHospital({Key? key}) : super(key: key);

  @override
  State<HomePageHospital> createState() => _HomePageHospitalState();
}

class _HomePageHospitalState extends State<HomePageHospital> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePageHospital()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserSearchScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileHospital()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(94, 110, 165, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromRGBO(94, 110, 165, 1),
            color: Colors.white,
            activeColor: Colors.white,
            gap: 8,
            onTabChange: _onItemTapped,
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticiasScreen()),
                  );
                },
                child: Container(
                  height: 55,
                  width: 55,
                  child: Icon(Icons.chat, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 185, 161, 255),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrincipaisDemandasScreen()),
                  );
                },
                child: Container(
                  height: 55,
                  width: 55,
                  child:
                      Icon(Icons.calendar_today, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 185, 161, 255),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQScreen()),
                  );
                },
                child: Container(
                  height: 55,
                  width: 55,
                  child: Icon(Icons.star, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 185, 161, 255),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalhesAppScreen()),
                  );
                },
                child: Container(
                  height: 55,
                  width: 55,
                  child: Icon(Icons.fingerprint, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 185, 161, 255),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .10),
          Column(
            children: [
              SizedBox(
                width: 1200,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: const Color.fromARGB(255, 110, 98, 204),
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 130,
                              width: 300,
                              child: Icon(Icons.medical_services,
                                  size: 50, color: Colors.white),
                            ),
                            const Text(
                              'Escolha os tipos de médicos de acordo com sua necessidade.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 181, 155, 254),
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 130,
                              width: 300,
                              child: Icon(Icons.access_time,
                                  size: 50, color: Colors.white),
                            ),
                            const Text(
                                'Diminua o congestionamento dos hospitais.',
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: const Color.fromARGB(255, 122, 109, 218),
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 130,
                              width: 300,
                              child: Icon(Icons.health_and_safety,
                                  size: 50, color: Colors.white),
                            ),
                            const Text(
                                'Melhore a qualidade do seu atendimento e tratamento.',
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
