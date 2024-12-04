import 'package:flutter/material.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias'),
        backgroundColor: Color.fromRGBO(94, 110, 165, 1),
      ),
      body: Center(
        child: Text(
          'Aqui serão exibidas as últimas notícias relevantes para os usuários.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PrincipaisDemandasScreen extends StatelessWidget {
  const PrincipaisDemandasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principais Demandas'),
        backgroundColor: Color.fromRGBO(94, 110, 165, 1),
      ),
      body: Center(
        child: Text(
          'Aqui serão listadas as principais demandas e solicitações dos usuários, com detalhes de cada uma.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Color.fromRGBO(94, 110, 165, 1),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('1. Como usar o app?'),
            subtitle: Text('O app foi projetado para facilitar a busca e agendamento de consultas médicas.'),
          ),
          ListTile(
            title: Text('2. Como buscar um médico?'),
            subtitle: Text('Utilize a barra de pesquisa e filtre por especialidade ou nome.'),
          ),
          ListTile(
            title: Text('3. Como agendar uma consulta?'),
            subtitle: Text('Após encontrar um médico, você pode agendar diretamente pelo app.'),
          ),
          // Adicione mais perguntas e respostas conforme necessário
        ],
      ),
    );
  }
}

class DetalhesAppScreen extends StatelessWidget {
  const DetalhesAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes sobre o App'),
        backgroundColor: Color.fromRGBO(94, 110, 165, 1),
      ),
      body: Center(
        child: Text(
          'Este aplicativo foi desenvolvido para facilitar o acesso a médicos e serviços de saúde de forma rápida e prática.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

