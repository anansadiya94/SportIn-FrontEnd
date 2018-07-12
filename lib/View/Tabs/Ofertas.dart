import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:sportin/View/Crear_Oferta/CrearOferta.dart';
import 'package:sportin/View/Tabs/Offers_Types/Pendientes.dart' as a;
import 'package:sportin/View/Tabs/Offers_Types/Aceptadas.dart' as b;
import 'package:sportin/View/Tabs/Offers_Types/Rechazadas.dart' as c;

class Ofertas extends StatefulWidget {
  @override
  MyOfertasState createState() => new MyOfertasState();
}

class MyOfertasState extends State<Ofertas> with SingleTickerProviderStateMixin {
  TabController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ofertas'),
        automaticallyImplyLeading: false,
        backgroundColor: color_appbar,
      ),
      backgroundColor: color_background,
      body: new ListView(
        children: <Widget>[
          new RaisedButton(
            color: color_icon_crearoferta,
            onPressed: () {Navigator.push(context,new MaterialPageRoute(builder: (context) => new CrearOferta()),);},
            child: new Text(
              'Crear oferta',
              style: new TextStyle(color: color_backgroung_text,fontSize: 20.0,),
            ),
          ),
          new Container(
            decoration: new BoxDecoration(color: color_ofertas_appbat),
            child: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  icon: const Icon(Icons.access_time),
                  text: 'Pendiente',
                ),
                new Tab(
                  icon: const Icon(Icons.done),
                  text: 'Aceptadas',
                ),
                new Tab(
                  icon: const Icon(Icons.close),
                  text: 'Rechazadas',
                ),
              ],
            ),
          ),
          new Container(
            height: 800.0,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                new a.Pendientes(),
                new b.Aceptadas(),
                new c.Rechazadas()
              ]
            ),
          ),
        ],
      ),
    );
  }
}
