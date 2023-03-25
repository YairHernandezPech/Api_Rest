import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final _controller =
      TextEditingController(); // controlador del campo de entrada de texto
  String _query = ''; // consulta de búsqueda

  Future<void> _search() async {
    // hacer una solicitud GET a la API REST con la consulta de búsqueda como parte de la URL
    final response = await http.get(Uri.parse(
        'https://mi-api-rest.fly.dev/api/nombre-buscar?nombre=$_query'));

    if (response.statusCode == 200) {
      // si la solicitud fue exitosa, se convierte la respuesta JSON a un objeto Dart
      final data = json.decode(response.body);
      print(data);
    } else {
      // si la solicitud falló, se muestra el código de estado y el mensaje de error
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _search,
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}
