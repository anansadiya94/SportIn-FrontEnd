import 'dart:async';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:sportin/View/Tabs/Home.dart' as first;
import 'package:sportin/View/Tabs/Lupa.dart' as second;
import 'package:sportin/View/Tabs/Ofertas.dart' as third;
import 'package:sportin/View/Tabs/Notificaciones.dart' as fourth;
//import 'package:sportin/View/Tabs/Perfil.dart' as fifth;
//import 'package:sportin/View/frienddetails/friend_details_page.dart' as fifth;
import 'package:sportin/View/frienddetails/friend_details_page.dart';
import 'package:sportin/View/friends/friend.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;

class Tabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController controller;
  var token = globals.tokenPerUser;
  Future<http.Response> _response;

  @override
  void initState() {
    super.initState();
    _refresh();
    controller = new TabController(vsync: this, length: 5);
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull("http://18.218.97.74/sportin-web/symfony/web/app_dev.php/user/$token"),
        headers : {
          "Accept": "application/json"
        }
    );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: color_appbar,
        child: new TabBar(
          controller: controller,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.home,)),
            new Tab(icon: new Icon(Icons.search)),
            new Tab(icon: new Icon(Icons.assignment)),
            new Tab(icon: new Icon(Icons.notifications)),
            new Tab(icon: new Icon(Icons.account_circle)),
          ]
        )
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new first.Home(),
          new second.Lupa(),
          new third.Ofertas(),
          new fourth.Notificaciones(),
          new FutureBuilder(
          future: _response,
          builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData)
              return new Text('Loading...');
            else if (response.data.statusCode != 200) {
              return new Text('Could not connect to User service.');
            } else {
              List json = jsonCodec.decode(response.data.body);
              Friend yo = new Friend(
                avatar: json[0]['profilePhoto'], 
                name: json[0]['userName'], 
                surname: json[0]['surname'], 
                bio: json[0]['bio'], email: json[0]['email'], 
                location: json[0]['populationName'], 
                id: '10', 
                rol: 'jugador', 
                edad: json[0]['birthDate'], 
                sexo:json[0]['sex'], 
                pierna: json[0]['foot'], 
                peso: json[0]['weight'], 
                altura:json[0]['height'],
                position: json[0]['playerPositionName'], 
                photoPosition: json[0]['photoPosition'],
                historial:json[0]['historial'], 
                nacionalidad:json[0]['countryName']);
              return new FriendDetailsPage(yo, 'mio', '', avatarTag: 0);
            }
          }
        ),
        ]
      )
    );
  }
}