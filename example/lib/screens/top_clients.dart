import 'package:flutter/material.dart';
import 'package:ziggeo_example/screens/lists/list.dart';

class TopClientsScreen extends StatefulWidget {
  static const String routeName = 'title_clients';

  @override
  _TopClientsScreenState createState() => _TopClientsScreenState();
}

class _TopClientsScreenState extends State<TopClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: InfoList(clients)),
    );
  }

  final clients = [
    ListDataObject(
        url: 'https://sap.com', imagePath: 'assets/img/clients/logo_sap.png'),
    ListDataObject(
        url: 'https://www.gofundme.com',
        imagePath: 'assets/img/clients/logo_gofundme.png'),
    ListDataObject(
        url: 'https://www.post.ch/en',
        imagePath: 'assets/img/clients/logo_swisspost.png'),
    ListDataObject(
        url: 'https://www.virginatlantic.com',
        imagePath: 'assets/img/clients/logo_virgin.png'),
    ListDataObject(
        url: 'https://itslearning.com',
        imagePath: 'assets/img/clients/logo_itslearning.png'),
    ListDataObject(
        url: 'https://www.calliduscloud.com',
        imagePath: 'assets/img/clients/logo_callidus.png'),
    ListDataObject(
        url: 'http://www.hireiqinc.com',
        imagePath: 'assets/img/clients/logo_hireiq.png'),
    ListDataObject(
        url: 'https://www.fiverr.com',
        imagePath: 'assets/img/clients/logo_fiverr.png'),
    ListDataObject(
        url: 'https://circleup.com',
        imagePath: 'assets/img/clients/logo_circleup.png'),
    ListDataObject(
        url: 'https://us.youcruit.com',
        imagePath: 'assets/img/clients/logo_youcruit.png'),
    ListDataObject(
        url: 'https://www.netflix.com',
        imagePath: 'assets/img/clients/logo_netflix.png'),
    ListDataObject(
        url: 'https://spotify.com',
        imagePath: 'assets/img/clients/logo_spotify.png'),
    ListDataObject(
        url: 'http://www.stern.nyu.edu',
        imagePath: 'assets/img/clients/logo_nyustern.png'),
    ListDataObject(
        url: 'https://dubizzle.com',
        imagePath: 'assets/img/clients/logo_dubizzle.png'),
    ListDataObject(
        url: 'https://usv.com', imagePath: 'assets/img/clients/logo_usv.png'),
    ListDataObject(
        url: 'https://www.mavenclinic.com',
        imagePath: 'assets/img/clients/logo_mavenclinic.png'),
  ];
}
