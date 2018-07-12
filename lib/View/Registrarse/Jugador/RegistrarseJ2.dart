import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Registrarse/Jugador/RegistrarseJ3.dart';

enum SingingCharacter { hombre, mujer }

class RegistrarseJ2 extends StatefulWidget {
  final _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final List _dias;
  final List _any;
  RegistrarseJ2(this._id,this._name,this._surname,this._email,this._password,this._dias,this._any);
  @override
  _RegistrarseJ2State createState() => new _RegistrarseJ2State(_id,_name,_surname,_email,_password,_dias,_any);
}

class _RegistrarseJ2State extends State<RegistrarseJ2> {
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
  final List _dias;
  final List _any;
  String _sexo;
  String _fecha;
  List<String> _altura = new List<String>();
  List<String> _peso = new List<String>();

  _RegistrarseJ2State(this._id,this._name,this._surname,this._email,this._password,this._dias,this._any);
  SingingCharacter _character = SingingCharacter.hombre;
  void _submit() async{
    _fecha = any[_selectedAny]+'-'+ (_selectedMes+1).toString()+'-'+ dias[_selectedDia];
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
    if(_character==SingingCharacter.hombre) {
      _sexo="H";
    }
    else {
      _sexo="M";
    }
    for(int i=100; i<250; i++) {
      _altura.add(i.toString());
    }
    for(int i=40; i<100; i++) {
      _peso.add(i.toString());
    }
    print('Sexo: ' + _sexo + ' Fecha: ' + _fecha + ' Nacionalidad: ' +  _valueCString + ' Nacionalidadid: '+ _nacionalidad.toString() + ' Localidad: ' + _valuePString + ' Localidadid: '+ _localiadad.toString());
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => 
      new RegistrarseJ3(_id,_name,_surname,_email,_password,_sexo,_fecha,_nacionalidad,_localiadad,_altura,_peso)),);
  }

  var _selectedDia = 0;
  var _selectedMes = 0;
  var _selectedAny = 0;
  List get dias => _dias;
  var mes =['Enero','Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre','Octubre', 'Noviembre', 'Diciembre'];
  List get any => _any;
  
  Widget _buildBottomPicker() {
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
                  _selectedDia = index;
                });
              },
              children:
                new List<Widget>.generate(dias.length, (int index) {
                  return new Center(child:new Text(dias[index]),);  
                }
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPicker2() {
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
                  _selectedMes = index;
                });
              },
              children:
                new List<Widget>.generate(mes.length, (int index) {
                  return new Center(child: new Text(mes[index]),);
                }
              ), 
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPicker3() {
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
                  _selectedAny = index;
                });
              },
              children:
                new List<Widget>.generate(any.length, (int index) {
                  return new Center(child:new Text(any[index]),);                      
                }
              ),
            ),
          ),
        ),
      ),
    );
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
                      value: 0.50,
                    ),
                    new Column(
                      children: <Widget>[
                        new Text('¿Sexo?', 
                        style: new TextStyle(
                          color: color_signup_button,
                          fontSize: 20.0,
                          ),
                        ),
                        new RadioListTile<SingingCharacter>(
                          title: const Text('Hombre'),
                          value: SingingCharacter.hombre,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) { setState(() { _character = value; }); },
                        ),
                        new RadioListTile<SingingCharacter>(
                          title: const Text('Mujer'),
                          value: SingingCharacter.mujer,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) { setState(() { _character = value; }); },
                        ),
                      ],
                    ),
                    new Text('Introduce Fecha de Nacimiento',style: new TextStyle(color: color_signup_button,fontSize: 20.0,),),
                    new Row(
                      children: <Widget>[
                        new Container(
                          height: 40.0,
                          width: 60.0,
                          child: new ListTile(title: new Text(dias[_selectedDia], textAlign: TextAlign.center,),
                              onTap: () async {
                              await showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {return _buildBottomPicker();},);}
                          ),
                        ),
                        new Text('-'),
                        new Container(
                          height: 40.0,
                          width: 130.0,
                          child: new ListTile(title: new Text(mes[_selectedMes],textAlign: TextAlign.center,),
                            onTap: () async {
                            await showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomPicker2();},);}  
                          ),
                        ),
                        new Text('-'),
                        new Container(
                          height: 40.0,
                          width: 80.0,
                          child: new ListTile(title: new Text(any[_selectedAny], textAlign: TextAlign.center,),
                            onTap: () async {
                            await showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomPicker3();},);}
                          ),  
                        ),  
                      ],       
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