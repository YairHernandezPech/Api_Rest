import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../menuLateral.dart';
import 'getYisus.dart';

//30.20
class EliminarYisus extends StatelessWidget {
  const EliminarYisus({super.key});

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
        title: Center(child: Text("Api Rest Jesus Pech Eliminar")),
      ),
      drawer: const menulateral(),
      body: homeYisus(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPageYisus,
        label: Text("Eliminar"),
      ),
    );
  }

  void navigateToAddPageYisus() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPageYisus(),
    );
    Navigator.push(context, route);
  }
}

class AddTodoPageYisus extends StatefulWidget {
  const AddTodoPageYisus({super.key});

  @override
  State<AddTodoPageYisus> createState() => _AddTodoPageYisusState();
}

class _AddTodoPageYisusState extends State<AddTodoPageYisus> {
  TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: 'id'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: submitData, child: Text('Eliminar'))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final id = idController.text;
    final body = {
      "_id": id,
    };
    final url = 'https://abet24.fly.dev/api-yisus/delete-product/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idController.text = '';
      /*nombreController.text = '';
      imgController.text = '';
      precioController.value = '';
      fechaCracionController.text = '';*/
      print('Se a eliminado');
      showSuccesMenssage('Se a eliminado');
    } else {
      showErrorMenssage('A fallado la eliminacion');
      print('A fallado la eliminacion');
      print(response.body);
    }
  }

  /*void showSuccesMenssage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
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
        style: TextStyle(color: Color.fromARGB(255, 2, 144, 19)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
