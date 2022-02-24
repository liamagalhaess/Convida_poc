import 'package:convida/event_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String _url = "http://app-convida.ufpr.br";

//Lista de administradores do aplicativo
Future<List> getAllAdmins(BuildContext context) async {
  final String request = "$_url/users/findAllAdmin";
  dynamic response;

  try {
    response = await http.get(request);
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      //debugPrint("Chegou no if");
      return parseEvents(response.body);
    }else{
      //errorStatusCode(response.statusCode, context, "Erro ao carregar Eventos");
      return null;
    }
  } catch (e) {
    debugPrint("Erro desconhecido" + response.statusCode );
    return null;
  }
}Future<List> getAllUsers(BuildContext context) async {
  final String request = "$_url/users";
  dynamic response;

  try {
    response = await http.get(request);
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      debugPrint("Chegou no if");
      return parseEvents(response.body);
    }else{
      //errorStatusCode(response.statusCode, context, "Erro ao carregar Eventos");
      return null;
    }
  } catch (e) {
    debugPrint("Erro desconhecido" + response.statusCode );
    return null;
  }
}



//---------------Ainda não está fubcionando-----------------------
void removeAdmin(String userId) async {
  //var mapHeaders = getHeaderToken(token);
  final String request = "$_url/events/removeadm/userId=$userId";
  dynamic response;
  try {
    response = await http.delete(request);// , headers: mapHeaders);
    //printRequisition(request, response.statusCode, "Get Remove Adm");
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
    } else {
      //errorStatusCode(response.statusCode, context, "Erro ao Confirmar Presença");
    }
  } catch (e) {
    debugPrint("Erro desconhecido " + "Erro: $e" + response.statusCode );
    //showError("Erro desconhecido", "Erro: $e", context);
  }
}
