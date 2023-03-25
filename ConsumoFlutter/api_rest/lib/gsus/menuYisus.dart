import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'getYisus.dart';
import '../menuLateral.dart';

//30.20
class MenuYisus extends StatelessWidget {
  const MenuYisus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: TodoYisus(),
    );
  }
}

class TodoYisus extends StatefulWidget {
  const TodoYisus({super.key});

  @override
  State<TodoYisus> createState() => _TodoYisusState();
}

class _TodoYisusState extends State<TodoYisus> {
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
        title: Center(child: Text("Api Rest Jesus Pech Añadir")),
      ),
      drawer: const menulateral(),
      body: homeYisus(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPageYisus,
        label: Text("Añadir"),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
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
            controller: nameController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(hintText: 'Precio'),
          ),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(hintText: 'Cantidad'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: submitDataYisus, child: Text('Subir'))
        ],
      ),
    );
  }

  Future<void> submitDataYisus() async {
    final name = nameController.text;
    final price = priceController.text;
    final quantity = quantityController.text;
    final body = {"name": name, "price": price, "quantity": quantity};
    // ignore: prefer_const_declarations
    final url = 'https://abet24.fly.dev/api-yisus/add-product';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      nameController.text = '';
      priceController.text = '';
      quantityController.text = '';
      print('Se a creado');
      showSuccesMenssage('Se a creado');
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
        style: TextStyle(color: Color.fromARGB(255, 0, 152, 68)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
