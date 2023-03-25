import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../menuLateral.dart';
import 'getYisus.dart';

//30.20
class ActualizarYisus extends StatelessWidget {
  const ActualizarYisus({super.key});

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
        title: Center(child: Text("Api Rest Jesus Pech Actualizar")),
      ),
      drawer: const menulateral(),
      body: homeYisus(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text("Actualizar"),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: 'id'),
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(hintText: 'Precio'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(hintText: 'Cantidad'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: submitData, child: Text('Actualizar'))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final id = idController.text;
    final name = nameController.text;
    final price = priceController.text;
    final quantity = quantityController.text;
    final body = {
      "_id": id,
      "name": name,
      "price": price,
      "quantity": quantity,
    };
    final url = 'https://abet24.fly.dev/api-yisus/update-product/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idController.text = '';
      nameController.text = '';
      priceController.text = '';
      quantityController.text = '';
      print('Se a creado');
      showSuccesMenssage('Se a Actualizado');
    } else {
      showErrorMenssage('A fallado la creación');
      print('A fallado la creación');
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
        style: TextStyle(color: Color.fromARGB(255, 7, 164, 46)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
