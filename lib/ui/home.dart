import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List lista = [];
  int index = 0;
  bool mostrarMenu = false;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final jsonString = await rootBundle.loadString(
      'assets/mockup/funcionarios.json',
    );

    final data = json.decode(jsonString);

    setState(() {
      lista = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lista.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final f = lista[index];

    return Scaffold(
      appBar: AppBar(title: const Text("Funcionários")),
      body: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                setState(() {
                  mostrarMenu = !mostrarMenu;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(blurRadius: 8, color: Colors.black12),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(f["nome"]),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            if (mostrarMenu)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 180, 186, 187),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black12),
                  ],
                ),
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    children: List.generate(lista.length, (i) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        title: Text(
                          lista[i]["nome"],
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          setState(() {
                            index = i;
                            mostrarMenu = false;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),
            const SizedBox(height: 20),

            Card(
              margin: const EdgeInsets.all(100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(f["avatar"]),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      f["nome"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(f["cargo"]),
                    Text("R\$ ${f["salario"]}"),
                    Text("Contratado em: ${f["dataContatacao"]}"),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: index > 0 ? () => setState(() => index--) : null,
                  child: const Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: index < lista.length - 1
                      ? () => setState(() => index++)
                      : null,
                  child: const Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
