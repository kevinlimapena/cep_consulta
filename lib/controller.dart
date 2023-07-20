 
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _users = [];
  
  Future<List<Map<String, dynamic>>> pegarUsuarios() async {
    var url = Uri.parse('https://servicodados.ibge.gov.br/api/v2/censos/nomes');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Deu erro');
    }
  }

  Future<void> buscarInformacoes(String nome) async {
    var usuarios = await pegarUsuarios();
    List<Map<String, dynamic>> usuariosEncontrados = [];

    for (var i = 0; i < usuarios.length; i++) {
      var usuario = usuarios[i];
      if (usuario['nome'].startsWith(nome.toUpperCase())) {
        usuariosEncontrados.add(usuario);
      }
    }

 
  }
  