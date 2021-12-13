
import 'dart:convert';

import 'package:convida/models/user.dart';
import 'package:flutter/material.dart';

List<User> parseEvents(String responseBody) {
  final parsedEvents = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<User> user =
  parsedEvents.map<User>((json) => User.fromJson(json)).toList();

  return user;
}

User parseEvent(String responseBody) {
  dynamic parsedEvent = json.decode(responseBody);
  final User user = User.fromJson(parsedEvent);
  //debugPrint(" Chegou no parseEvent");

  return user;
}