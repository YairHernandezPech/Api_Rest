import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController(); // controlador del campo de entrada de texto
  String _query = ''; // consulta de búsqueda

  Future<void> _search() async {
    // hacer una solicitud GET a la API REST con la consulta de búsqueda como parte de la URL
    final response = await http.get(Uri.parse('https://mi-api-rest.fly.dev/api/nombre-buscar?nombre=$_query'));

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
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Buscar...',
            ),
            onChanged: (value) {
              setState(() {
                _query = value; // actualizar la consulta de búsqueda
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: _search,
        ),
      ],
    );
  }
}
