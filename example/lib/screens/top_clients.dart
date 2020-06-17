import 'package:flutter/material.dart';
import 'package:ziggeo_example/screens/lists/list.dart';

class TopClientsScreen extends StatelessWidget {
  static const String routeName = '/clients';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: InfoList(clients, false)),
    );
  }

  final clients = [
    ListDataObject('https://sap.com', 'assets/img/clients/logo_sap.png'),
    ListDataObject(
        'https://www.gofundme.com', 'assets/img/clients/logo_gofundme.png'),
    ListDataObject(
        'https://www.post.ch/en', 'assets/img/clients/logo_swisspost.png'),
    ListDataObject(
        'https://www.virginatlantic.com', 'assets/img/clients/logo_virgin.png'),
    ListDataObject(
        'https://itslearning.com', 'assets/img/clients/logo_itslearning.png'),
    ListDataObject('https://www.calliduscloud.com',
        'assets/img/clients/logo_callidus.png'),
    ListDataObject(
        'http://www.hireiqinc.com', 'assets/img/clients/logo_hireiq.png'),
    ListDataObject(
        'https://www.fiverr.com', 'assets/img/clients/logo_fiverr.png'),
    ListDataObject(
        'https://circleup.com', 'assets/img/clients/logo_circleup.png'),
    ListDataObject(
        'https://us.youcruit.com', 'assets/img/clients/logo_youcruit.png'),
    ListDataObject(
        'https://www.netflix.com', 'assets/img/clients/logo_netflix.png'),
    ListDataObject(
        'https://spotify.com', 'assets/img/clients/logo_spotify.png'),
    ListDataObject(
        'http://www.stern.nyu.edu', 'assets/img/clients/logo_nyustern.png'),
    ListDataObject(
        'https://dubizzle.com', 'assets/img/clients/logo_dubizzle.png'),
    ListDataObject('https://usv.com', 'assets/img/clients/logo_usv.png'),
    ListDataObject('https://www.mavenclinic.com',
        'assets/img/clients/logo_mavenclinic.png'),
  ];
}
