
import 'package:convida/screens/listar_administradores/listar_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Convida());
}

class Convida extends StatelessWidget {
  const Convida({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convida',
      theme: ThemeData(
        primarySwatch: Colors.red,
         // user.dart: Color(0xFF255D83),
      ),
      home:  const ListAdmin(title: "Listar Administradores"),
    );
  }
}





