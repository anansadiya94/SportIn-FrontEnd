import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Registrarse/Jugador/RegistrarseJ4.dart';

enum Pierna { derecha, izquierda }

class RegistrarseJ3 extends StatefulWidget { 
  final int _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final String _sexo;
  final String _fecha;
  final int _nacionalidad;
  final int _localiadad;
  final List _altura;
  final List _peso;
  RegistrarseJ3(this._id,this._name,this._surname,this._email,this._password,this._sexo,this._fecha,this._nacionalidad,this._localiadad,this._altura,this._peso);
  @override
  RegistrarseJ3State createState() => new RegistrarseJ3State(_id,_name,_surname,_email,_password,_sexo,_fecha,_nacionalidad,_localiadad,_altura,_peso);
}

class RegistrarseJ3State extends State<RegistrarseJ3> {
  final int _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final String _sexo;
  final String _fecha;
  final int _nacionalidad;
  final int _localiadad;
  final List _altura;
  final List _peso;
  RegistrarseJ3State(this._id,this._name,this._surname,this._email,this._password,this._sexo,this._fecha,this._nacionalidad,this._localiadad,this._altura,this._peso);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  Pierna _piernaCharacter = Pierna.derecha;
  
  String _pierna;
  String _valuePosition;
  int _posicion;
  List<String> _valuesPo = new List<String>();
  List<int> _valuesIdPo = new List<int>();

  @override
  void initState() {
    super.initState();
    _valuesPo = globals.positionsGS;
    _valuesIdPo  = globals.idPositionsG;
    _valuePosition = _valuesPo.elementAt(0);
  }

  void _onChangedPosition(String value) {
    setState(() {
      _valuePosition = value;
    });
  }

  Widget _buildBottomPickerH() {
    final FixedExtentScrollController scrollController = new FixedExtentScrollController(initialItem: 0);
    return new Container(
      height: 216.0,
      color: CupertinoColors.white,
      child: new DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: new GestureDetector(
          onTap: () {},
          child: new SafeArea(
            child: new CupertinoPicker(
              scrollController: scrollController,
              itemExtent: 40.0,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedH = index;
                });
              },
              children:
                new List<Widget>.generate(altura.length, (int index) {
                  return new Center(child:new Text(altura[index]),);  
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBottomPickerW() {
    final FixedExtentScrollController scrollController = new FixedExtentScrollController(initialItem: 0);
    return new Container(
      height: 216.0,
      color: CupertinoColors.white,
      child: new DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: new GestureDetector(
          onTap: () {},
          child: new SafeArea(
            child: new CupertinoPicker(
              scrollController: scrollController,
              itemExtent: 40.0,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedW = index;
                });
              },
              children:
                new List<Widget>.generate(peso.length, (int index) {
                  return new Center(child:new Text(peso[index]),);  
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _submit() async{
    final form = formKey.currentState;
    for(int i=0; i<_valuesPo.length; i++) {
      if(_valuesPo[i]==_valuePosition) {
        _posicion = _valuesIdPo[i];
      }
    }
    if (form.validate()) {
      form.save();
    }
    if(_piernaCharacter==Pierna.derecha) {
      _pierna="D";
    }
    else {
      _pierna="Z";
    }
    int alturaInt = int.parse(altura[_selectedH]);
    assert(alturaInt is int);
    int pesoInt = int.parse(peso[_selectedW]);
    assert(alturaInt is int);
    print('Posición: ' + _posicion.toString() + ' Pierna: ' + _pierna + ' Altura: ' + altura[_selectedH] + ' Peso: ' + peso[_selectedW] );
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => 
      new RegistrarseJ4(_id,_name,_surname,_email,_password,_sexo,_fecha,_nacionalidad,_localiadad,_posicion,_pierna,alturaInt,pesoInt)),);
  }

  var _selectedH = 0;
  var _selectedW = 0;
  List get altura => _altura;
  List get peso => _peso;
  
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
                      value: 0.75,
                    ),
                    new Text('Posición en el campo?',
                        style: new TextStyle(
                            color: color_signup_button,
                            fontSize: 20.0,
                          ),
                        ),
                    new DropdownButton(
                      value: _valuePosition,
                      items: _valuesPo.map((String value){
                        return new DropdownMenuItem(
                          value: value,
                          child: new Row(
                            children: <Widget>[
                              new Text('$value')
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String value){_onChangedPosition(value);},
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new Column(
                      children: <Widget>[
                        new Text('¿Pierna?', 
                        style: new TextStyle(
                          color: color_signup_button,
                          fontSize: 20.0,
                          ),
                        ),
                        new RadioListTile<Pierna>(
                          title: const Text('Derecha'),
                          value: Pierna.derecha,
                          groupValue: _piernaCharacter,
                          onChanged: (Pierna v2) { setState(() { _piernaCharacter = v2; }); },
                        ),
                        new RadioListTile<Pierna>(
                          title: const Text('Izquierda'),
                          value: Pierna.izquierda,
                          groupValue: _piernaCharacter,
                          onChanged: (Pierna v2) { setState(() { _piernaCharacter = v2; }); },
                        ),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Text('¿Peso?',
                        style: new TextStyle(
                            color: color_signup_button,
                            fontSize: 20.0,
                          ),
                        ),
                        new Container(
                          height: 40.0,
                          width: 60.0,
                          child: new ListTile(title: new Text('${peso[_selectedW]} kg', textAlign: TextAlign.center,),
                              onTap: () async {
                              await showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {return _buildBottomPickerW();},);}
                          ),
                        ),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Text('¿Altura?',
                        style: new TextStyle(
                            color: color_signup_button,
                            fontSize: 20.0,
                          ),
                        ),
                        new Container(
                          height: 40.0,
                          width: 60.0,
                          child: new ListTile(title: new Text('${altura[_selectedH]} cm', textAlign: TextAlign.center,),
                              onTap: () async {
                              await showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {return _buildBottomPickerH();},);}
                          ),
                        ),
                      ],
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