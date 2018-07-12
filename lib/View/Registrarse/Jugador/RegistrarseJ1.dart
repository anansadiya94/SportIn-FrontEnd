import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Registrarse/Jugador/RegistrarseJ2.dart';

class RegistrarseJ1 extends StatefulWidget {
  final int _id;
  RegistrarseJ1(this._id);
  @override
  _RegistrarseJ1State createState() => new _RegistrarseJ1State(_id);
}

const jsonCodec = const JsonCodec();

class _RegistrarseJ1State extends State<RegistrarseJ1> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final int _id;
  _RegistrarseJ1State(this._id);
  String _name;
  String _surname;
  String _email;
  String _password;
  List<String> _dias = new List<String>();
  List<String> _any = new List<String>();
  Map infoJson;
  String status;

  Map toJson() {
    return {"username" :_name, "surname" : _surname};
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _performLogin();
    }
  }
  
  Future<String> _popUpError() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
        title: Text('Correo existente'),
          content: new Text('Este correo ya existe en la base de datos, intenta otro.'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.navigate_before),
              color: Colors.blue,
              iconSize: 50.0,
              tooltip: 'Intentar otro',
              onPressed: () {Navigator.pop(context);},
            ),
          ],
        );
      }
    );
  }
  
  void _performLogin() async{
    for(int i=1; i<31; i++) {
      _dias.add(i.toString());
    }
    for(int i = 0; i<100; i++){
      _any.add((i+1950).toString());
    }
    var _responseCorreo = await http.get(
      Uri.encodeFull(globals.url+"repeatedEmail/$_email"),
      headers : {
        "Accept": "application/json"
      }
    );
    print("Response:");
    print(_responseCorreo.body);
    infoJson = jsonCodec.decode(_responseCorreo.body);
    status = (infoJson["status"]);
    if(status == 'error') {
      _popUpError();
    }else{
      print('Información del usuario:');
      print('Nombre: ' + _name + ' Correo: ' + _email + ' Contraseña: ' +_password);
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => 
        new RegistrarseJ2(_id,_name,_surname,_email,_password,_dias,_any)),);
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: color_background,
      body: new Form(
        key: formKey,
        child: new Theme(
          data: new ThemeData(
            inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(
              color: color_signup_button,
              fontSize: 20.0,
              )
            )
          ),
          child: new Container(
            padding: const EdgeInsets.all(40.0),
            child: new ListView(
              children: [
                new Padding(padding: const EdgeInsets.only(left:40.0,right: 40.0)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new LinearProgressIndicator(
                      value: 0.33,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Leo",
                        labelText: 'Introduce Nombre',
                      ),
                      validator: (val) {
                        if(val.length==0) {return 'Campo obligatorio, introduce nombre.';}
                        if(val.length<2) {return 'Nombre demasiado corto, mínimo 2.';}
                        if(val.length>20) {return 'Nombre demasiado largo, máximo 20.';}
                      },
                      keyboardType: TextInputType.text,
                      onSaved: (val) => _name = val,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Messi",
                        labelText:'Introduce Apellido',
                      ),
                      validator: (val) {
                        if(val.length==0) {return 'Campo obligatorio, introduce apellido.';}
                        if(val.length<2) {return 'Apellido demasiado corto, mínimo 2.';}
                        if(val.length>20) {return 'Apellido demasiado largo, máximo 20.';}
                      },
                      keyboardType: TextInputType.text,
                      onSaved: (val) => _surname = val,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Leo.messi@gmail.com",
                        labelText: 'Introduce Correo'
                      ),
                      validator: (val) {
                        if(val.length==0) {return 'Campo obligatorio, introduce correo.';}
                        if(val.length<5) {return 'Correo demasiado corto, mínimo 5.';}
                        if(val.length>45) {return 'Correo demasiado largo, máximo 45.';}
                        if(!val.contains('@')) {return 'Correo no válido, debe contener "@".';}
                        if(!val.contains('.')) {return 'Correo no válido, debe contener ".".';}
                      },
                      onSaved: (val) => _email = val,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Introduce Contraseña'
                      ),
                      validator: (val) {
                        if(val.length==0) {return 'Campo obligatorio, introduce contraseña.';}
                        if(val.length<6) {return 'Contraseña demasiado corta, mínimo 6.';}
                        if(val.length>15) {return 'Contraseña demasiado larga, máximo 15.';}
                      },
                      onSaved: (val) => encriptar(val),
                      obscureText: true,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new MaterialButton(
                      color: color_signup_button,
                      textColor: color_icon_text,
                      child: new Text('Siguiente'),
                      onPressed: _submit,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 5.0),),
                    new MaterialButton(
                      color: Colors.blueGrey,
                      textColor: color_icon_text,
                      child: new Text("Atras"),
                      onPressed: () {Navigator.pop(context);},
                    )
                  ],
                ),
              ]
            ),
          )
        ),
      ),
    );
  }

  void encriptar(String val){
    var bytes = utf8.encode(val); // data being hashed
    var digest = sha1.convert(bytes);  
    _password = '$digest';
  }
}
