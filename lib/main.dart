import 'package:flutter/material.dart';
import 'package:sportin/View/Portada.dart';
import 'package:sportin/View/Tabs.dart';
import 'package:sportin/View/Registrarse.dart';
import 'package:sportin/View/Iniciar_sesion.dart';
import 'package:sportin/View/Crear_Oferta/CrearOferta.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Portada(),
    routes: <String, WidgetBuilder>{
    "/tabs": (BuildContext context) => new Tabs(),
    "/login": (BuildContext context) => new Login(),
    "/signup": (BuildContext context) => new Signup(),
    "/crearOferta": (BuildContext context) => new CrearOferta(),
    }
  ));
}