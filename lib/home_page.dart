import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController Valor = TextEditingController();

  String resultado = 'Suas informasções aparecerão aqui';

  Api(String api) async {
    var url = 'https://api.postmon.com.br/v1/cep/$api';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var data = Data.fromJson(json);
    setState(() {
      if(data.complemento != null){
        resultado = "${data.logradouro}\n"
            "${data.complemento}\n"
            "${data.bairro}\n"
            "${data.cidade}";
      }else{
        resultado = "${data.logradouro}\n"
            "${data.bairro}\n"
            "${data.cidade}";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          setState(() {
            Valor.clear();
            resultado = 'Suas informasções aparecerão aqui';
          });
          },
          icon: Icon(Icons.refresh,size: 33,),
        color: Colors.amber,)
      ],
        title: Text('CONSULTAR CEP', style: TextStyle(
          color: Colors.amber, fontSize: 25),),centerTitle: true,
        backgroundColor: Colors.black,),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: Valor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Digite o CEP',
                  hintStyle: TextStyle(color: Colors.black),
                                   border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  onPressed: (){
                Api(Valor.text);
              }, child: Text('Consultar',
                style: TextStyle(fontSize:20, color: Colors.amber),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              )
              ),
            ),
            Text(resultado, style: TextStyle(
              fontSize: 20
            ),)
          ]
        ),
      ),
    );
  }
}

class Data {
  final String logradouro;
  final String cidade;
  final String bairro;
  final String? complemento;

  Data({required this.cidade, required this.bairro, required this.complemento, required this.logradouro});

  factory Data.fromJson (Map json){
    return Data(
        logradouro: json['logradouro'],
        cidade: json['cidade'],
      bairro: json['bairro'],
      complemento: json['complemento']
    );

  }
}

