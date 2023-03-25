import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homeYisus extends StatefulWidget {
  const homeYisus({super.key});

  @override
  State<homeYisus> createState() => _homeYisusState();
}

class _homeYisusState extends State<homeYisus> {
  final url = Uri.parse("https://abet24.fly.dev/api-yisus/get-products");
  late Future<List<Producto>> productos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Producto>>(
          future: productos,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            snap.data![i].img,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                          /*Text(snap.data![i].img,
                              //snap.data![i].name,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),*/
                          title: Text(snap.data![i].name,
                              //snap.data![i].price.toString() + " pesos",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              snap.data![i].quantity.toString() + " cantidad",
                              //snap.data![i].quantity,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                          trailing: Text(
                              snap.data![i].price.toString() + " pesos",

                              //snap.data![i].id,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight
                                      .bold)), /*PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  child: const Text('Editar'),
                                  value: 'editar',
                                ),
                                const PopupMenuItem(
                                  child: Text('Eliminar'),
                                  value: 'eliminar',
                                )
                              ];
                            },
                          ),*/
                        ),
                        const Divider()
                      ],
                    );
                  });
            }
            if (snap.hasError) {
              return const Center(
                child: Text("Ha habido un problema"),
              );
            }

            return const CircularProgressIndicator();
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    productos = getProductosYisus();
  }

  Future<List<Producto>> getProductosYisus() async {
    final res = await http.get(url); //respuesta en texto
    final lista = List.from(jsonDecode(res.body));

    List<Producto> productos = [];
    // ignore: avoid_function_literals_in_foreach_calls
    lista.forEach((element) {
      final Producto product = Producto.fromJson(element);
      productos.add(product);
    });
    return productos;
  }
}

/*Future<RssFeed> fetchFeed() async {
try {
  final response = await http.get(Uri.parse(url), headers: {"Access-Control-Allow-Origin": "*"});
  return RssFeed.parse(response.body);
} catch (e) {
  print(e);
  return RssFeed(title: "Test");
  }}

  var feed = await fetchFeed();*/

class Producto {
  String id;
  String name;
  String img;
  String price;
  String quantity;

  Producto({
    required this.id,
    required this.name,
    required this.img,
    required this.price,
    required this.quantity,
  });

  factory Producto.fromJson(Map json) {
    return Producto(
        id: json["_id"],
        name: json["name"],
        img: json["img"],
        price: json["price"],
        quantity: json["quantity"]);
  }
}
