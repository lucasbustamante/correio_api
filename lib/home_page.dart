import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('CONSULTAR CEP', style: TextStyle(
            color: Colors.amber, fontSize: 25),),centerTitle: true,
          backgroundColor: Colors.black,),
        body: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite o CEP'
              ),
            ),
          ]
        ),
      ),
    );
  }
}
