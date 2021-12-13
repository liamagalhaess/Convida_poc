import 'package:convida/event_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String _url = "http://app-convida.ufpr.br";

Future<List> getAllAdms(BuildContext context) async {
  final String request = "http://app-convida.ufpr.br/users/findAllAdmin";
  dynamic response;

  //debugPrint("Chegou no getAll" );

  try {
    response = await http.get(request);

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      debugPrint("Chegou no if");
      return parseEvents(response.body);
    }else{

    }
  } catch (e) {
    //debugPrint("Erro desconhecido" + response.statusCode );
    return null;
  }
}
