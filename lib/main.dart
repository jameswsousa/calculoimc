import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.pink),
    home: HomeWidget(),
  ));
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 25) {
        _infoText = "Peso bacana  (${imc.toStringAsPrecision(4)})";
      } else {
        _infoText = "Acima do Peso  (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      body: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 150,
                  color: Colors.pink,
                ),
                TextFormField(
                  cursorColor: Colors.pink,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.pink, fontSize: 25),
                  decoration: InputDecoration(
                      hintText: "Digite seu peso",
                      hintStyle: TextStyle(color: Colors.pink[200]),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.pink, fontSize: 20)),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    }
                  },
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  
                  autofocus: false,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.pink,
                  style: TextStyle(color: Colors.pink, fontSize: 25),
                  decoration: InputDecoration(
                      hintText: "Digite sua altura(em cm)",
                      hintStyle: TextStyle(color: Colors.pink[200]),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.pink, fontSize: 20)),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState.validate()) {
                      calculate();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: <BoxShadow>[BoxShadow(offset: Offset(3, 3), blurRadius: 3,color: Colors.pink[800])],
                      color: Colors.pink,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _infoText,
                  style: TextStyle(fontSize: 25, color: Colors.pink),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
