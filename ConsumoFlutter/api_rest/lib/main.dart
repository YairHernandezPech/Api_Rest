import 'dart:convert';
import 'package:api_rest/shear.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'GetRest.dart';
import 'menuLateral.dart';

void main() {
  runApp(const MyApp());
}

//30.20
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // List items = [];
  @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Api Rest Añadir")),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => search())),
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const menulateral(),
      body: homePage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text("Añadir"),
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    Navigator.push(context, route);
  }
}

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController fechaCracionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: 'id'),
          ),
          TextField(
            controller: nombreController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          TextField(
            controller: imgController,
            decoration: InputDecoration(hintText: 'img url'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          TextField(
            controller: precioController,
            decoration: InputDecoration(hintText: 'Precio'),
          ),
          TextField(
            controller: fechaCracionController,
            decoration: InputDecoration(hintText: 'Dia-Mes-Año'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: submitData, child: Text('Subir'))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final id = idController.text;
    final nombre = nombreController.text;
    final img = imgController.text;
    final precio = precioController.text;
    final fechaCracion = fechaCracionController.text;
    final body = {
      "id": id,
      "nombre": nombre,
      "img": img,
      "precio": precio,
      "fechaCracion": fechaCracion
    };
    final url = 'https://mi-api-rest.fly.dev/api/nuevo';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idController.text = '';
      nombreController.text = '';
      imgController.text = '';
      precioController.text = '';
      fechaCracionController.text = '';
      print('Se a creado');
      showSuccesMenssage('Se a creado');
    } else {
      showErrorMenssage('A fallado la creación');
      print('A fallado la creación');
      print(response.body);
    }
  }

  void showSuccesMenssage(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMenssage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}