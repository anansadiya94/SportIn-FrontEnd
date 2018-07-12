import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Registrarse/Club/RegistrarseC3.dart';

class RegistrarseC2 extends StatefulWidget {
  final _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  RegistrarseC2(this._id,this._name,this._surname,this._email,this._password);
  @override
  RegistrarseC2State createState() => new RegistrarseC2State(_id,_name,_surname,_email,_password);
}

class RegistrarseC2State extends State<RegistrarseC2> {
  String _valueCString;
  int _nacionalidad;
  String _valuePString;
  int _localiadad;
  List<String> _valuesC = new List<String>();
  List<int> _valuesIdC = new List<int>();
  List<String> _valuesP = new List<String>();
  List<int> _valuesIdP = new List<int>();

  @override
  void initState() {
    super.initState();
    _valuesC= globals.contriesGS;
    _valuesIdC = globals.idContriesG;
    _valueCString = _valuesC.elementAt(58);
    _valuesP = globals.populationsGS;
    _valuesIdP = globals.idPopulationsG;
    _valuePString = _valuesP.elementAt(20);
  }

  void _onChangedC(String value) {
    setState(() {
      _valueCString = value;
    });
  }

  void _onChangedP(String value) {
    setState(() {
      _valuePString = value;
    });
  }
  
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final int _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  String _sexo;
  String _fecha;
  RegistrarseC2State(this._id,this._name,this._surname,this._email,this._password);
  
  void _submit() {
    final form = formKey.currentState;
    for(int i=0; i<_valuesC.length; i++) {
      if(_valuesC[i]==_valueCString) {
        _nacionalidad = _valuesIdC[i];
      }
    }
    for(int i=0; i<_valuesP.length; i++) {
      if(_valuesP[i]==_valuePString) {
        _localiadad = _valuesIdP[i];
      }
    }
    if (form.validate()) {
      form.save();
    }
    _sexo=null;
    _fecha=null;
    print(' Nacionalidad: ' + _nacionalidad.toString() + ' Localidad: ' +_localiadad.toString());
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => 
      new RegistrarseC3(_id,_name,_surname,_email,_password,_sexo,_fecha,_nacionalidad,_localiadad)),);
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
                      value: 0.66,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new Text('Nacionalidad?',
                        style: new TextStyle(
                            color: color_signup_button,
                            fontSize: 20.0,
                          ),
                        ),
                    new DropdownButton(
                      value: _valueCString,
                      items: _valuesC.map((String value){
                        return new DropdownMenuItem(
                          value: value,
                          child: new Row(
                            children: <Widget>[
                              new Text('$value')
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String value){_onChangedC(value);},
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new Text('Localidad?',
                        style: new TextStyle(
                            color: color_signup_button,
                            fontSize: 20.0,
                          ),
                        ),
                    new DropdownButton(
                      value: _valuePString,
                      items: _valuesP.map((String value){
                        return new DropdownMenuItem(
                          value: value,
                          child: new Row(
                            children: <Widget>[
                              new Text('$value')
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String value){_onChangedP(value);},
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new MaterialButton(
                      color: color_signup_button,
                      textColor: color_icon_text,
                      child: new Text("Siguiente"),
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
}