import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class UserSearchScreen extends StatefulWidget {
  @override
  UserSearchScreenState createState() => UserSearchScreenState();
}

class UserSearchScreenState extends State<UserSearchScreen> {
  String searchQuery = '';
  int _selectedIndex = 1;

  Future<bool> _onWillPop() async {
    if (_selectedIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pop(context);
    }
    return false;
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pesquisa de Médicos'),
          backgroundColor: Color.fromRGBO(234, 239, 255, 1),
        ),
        backgroundColor: Color.fromRGBO(234, 239, 255, 1),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(94, 110, 165, 1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Buscar por Especialidade',
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final users = snapshot.data!.docs.where((user) {
                    final especialidade = user['Especialidade'].toString().toLowerCase();
                    return especialidade.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Card(
                            margin: EdgeInsets.all(10),
                            color: Color.fromRGBO(94, 110, 165, 1),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      user['name'],
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(234, 239, 255, 1)),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Center(
                                    child: Text(
                                      user['email'],
                                      style: TextStyle(fontSize: 16, color: Color.fromRGBO(234, 239, 255, 1)),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Center(
                                    child: Text(
                                      'CRM: ${user['CRM']}',
                                      style: TextStyle(fontSize: 16, color: Color.fromRGBO(234, 239, 255, 1)),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Center(
                                    child: Text(
                                      'Especialidade: ${user['Especialidade']}',
                                      style: TextStyle(fontSize: 16, color: Color.fromRGBO(234, 239, 255, 1)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
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
              selectedIndex: _selectedIndex,
              onTabChange: _onTabChanged,
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
      ),
    );
  }
}
