import 'dart:ffi';
import 'dart:math';

import 'package:converter/widgets/drop_down.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EntradaPage(),
    );
  }
}

class EntradaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Bem vindo")),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomePage()
            ));
          },
          child: const Text('Ir para o conversor'),
        ),
      ),
    );
  }
}

class ResultadoPage extends StatelessWidget {
  ResultadoPage(this.resultado);

  final double resultado;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)
                ),
                child:
                Column(
                    children: [
                      Text("Resultado", style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                      Text(resultado.toString(), style: TextStyle(
                          color: Color(0xFF2849E5),
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ]
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color corPrincipal = Color(0xFF212936);
  Color corSecundaria = Color(0xFF2849E5);

  String _de = "Cm";
  String _para = "M";

  final _medidas = ["Mm", "Cm", "M", "Km"];

  double _resultado = 0;
  double _valor = 0;

  void calcular_resultado(String de, String para, double valor){

    if(de == "Mm"){
      if(para == "Mm"){
        _resultado = valor * 1;
      }
      if(para == "Cm"){
        _resultado = valor/10;
      }
      if(para == "M"){
        _resultado = valor/1000;
      }
      if(para == "Km"){
        _resultado = valor/1000000;
      }
    }
    if(de == "Cm"){
      if(para == "Mm"){
        _resultado = valor * 10;
      }
      if(para == "Cm"){
        _resultado = valor * 1;
      }
      if(para == "M"){
        _resultado = valor/100;
      }
      if(para == "Km"){
        _resultado = valor/100000;
      }
    }
    if(de == "M"){
      if(para == "Mm"){
        _resultado = valor * 1000;
      }
      if(para == "Cm"){
        _resultado = valor * 100;
      }
      if(para == "M"){
        _resultado = valor * 1;
      }
      if(para == "Km"){
        _resultado = valor/1000;
      }
    }
    if(de == "Km"){
      if(para == "Mm"){
        _resultado = valor * 1000000;
      }
      if(para == "Cm"){
        _resultado = valor * 100000;
      }
      if(para == "M"){
        _resultado = valor * 1000;
      }
      if(para == "Km"){
        _resultado = valor * 1;
      }
    }
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ResultadoPage(_resultado)
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.0,
                child: Text(
                  "Conversor de medidas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value){
                        setState(() {
                          _valor = double.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Valor a ser convertido",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                          color: corSecundaria
                        )
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customDropDown(_medidas, _de, (val) {
                          setState(() {
                            _de = val;
                          });
                        }),
                        FloatingActionButton(
                          heroTag: 'Inverter',
                          onPressed: (){
                            String temp = _de;
                            setState(() {
                              _de = _para;
                              _para = _de;
                            });
                          },
                          child: Icon(Icons.swap_horiz),
                          elevation:  0.0,
                          backgroundColor: corSecundaria
                        ),
                        customDropDown(_medidas, _para, (val) {
                          setState(() {
                            _para = val;
                          });
                        }),
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0)
                      ),
                      child:
                      Column(
                          children: [
                            FloatingActionButton.extended(
                                heroTag: 'Calcular',
                                onPressed: (){
                                  calcular_resultado(_de, _para, _valor);
                                },
                                label: const Text('Ver resultado'),
                                icon: Icon(Icons.arrow_right),
                                elevation:  0.0,
                                backgroundColor: corSecundaria
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
              )),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
        )
      ),
    );
  }
}

