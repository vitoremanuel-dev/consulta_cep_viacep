import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController();
  String endereco = '';
  String cidade = '';
  String estado = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Consultar CEP'),
            TextField(
              keyboardType: TextInputType.number,
              controller: cepController,
              onChanged: (value) async {
                var cep = value.trim().replaceAll("-", "");
                if (cep.length == 8) {
                  var response = await http
                      .get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
                  print(response.body);
                } else {
                  cidade = '';
                  estado = '';
                  endereco = '';
                }
              },
            )
          ],
        ),
      ),
    ));
  }
}
