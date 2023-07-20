import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  //lista vazia de usuarios da api  
  List<Map<String, dynamic>> _users = [];

//FUNCAO "PEGAR USUARIOS" É RESPONSAVEL POR RESGATAR A API E TRANSFORMAR ELA EM VALORES PALPAVEIS

  Future<List<Map<String, dynamic>>> pegarUsuarios() async {
    var url = Uri.parse('https://servicodados.ibge.gov.br/api/v2/censos/nomes');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Deu erro');
    }
  }
//LOGICA QUE BUSCA OS NOMES QUE O USUARIO DESEJA 

  Future<void> buscarInformacoes(String nome) async {
    var usuarios = await pegarUsuarios();
    List<Map<String, dynamic>> usuariosEncontrados = [];

    for (var i = 0; i < usuarios.length; i++) {
      var usuario = usuarios[i];
      if (usuario['nome'].startsWith(nome.toUpperCase())) {
        usuariosEncontrados.add(usuario);
      }
    }



    setState(() {
      _users = usuariosEncontrados;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
//TELA SCAFFOLD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Digite um nome',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              buscarInformacoes(_searchController.text);
            },
            child: Text('Buscar'),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                var user = _users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(user['nome']),
                  subtitle: Text(user['rank'].toString()),
                  trailing: Text(user['freq'].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
