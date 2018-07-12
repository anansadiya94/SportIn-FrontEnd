import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Welcome.dart';
import 'package:sportin/Model/PhotoPost.dart';
import 'package:sportin/Model/SignUpPost.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportin/View/Globals.dart' as globals;

class RegistrarseJ4 extends StatefulWidget { 
  final int _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final String _sexo;
  final String _fecha;
  final int _nacionalidad;
  final int _localiadad;
  final int _posicion;
  final String _pierna;
  final int _altura;
  final int _peso;
  RegistrarseJ4(this._id,this._name,this._surname,this._email,this._password,this._sexo,this._fecha,
    this._nacionalidad,this._localiadad,this._posicion,this._pierna,this._altura,this._peso);
  @override
  RegistrarseJ4State createState() => new RegistrarseJ4State(_id,_name,_surname,_email,_password,_sexo,_fecha,
    _nacionalidad,_localiadad,_posicion,_pierna,_altura,_peso);
}

class RegistrarseJ4State extends State<RegistrarseJ4> {
  final int _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final String _sexo;
  final String _fecha;
  final int _nacionalidad;
  final int _localiadad;
  final int _posicion;
  final String _pierna;
  final int _altura;
  final int _peso;
  RegistrarseJ4State(this._id,this._name,this._surname,this._email,this._password,this._sexo,this._fecha,
    this._nacionalidad,this._localiadad,this._posicion,this._pierna,this._altura,this._peso);
  
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _controllerBio = new TextEditingController();
  final TextEditingController _controllerHistorial = new TextEditingController();
  String _bio;
  String _historial;
  String _valueClString;
  int _clubId;
  List<String> _valuesCl = new List<String>();
  List<int> _valuesIdCl = new List<int>();
  Map infoJson;
  String status;
  String token;

  @override
  void initState() {
    super.initState();
    _valuesCl= globals.clubsGS;
    _valuesIdCl = globals.idClubsG;
    _valueClString = _valuesCl.elementAt(0);
  }

  void _onChangedCl(String value) {
    setState(() {
      _valueClString = value;
    });
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _bio = _controllerBio.text;
      _historial = _controllerHistorial.text;
      _performLogin();
    }
  }

  void _performLogin() {
    for(int i=0; i<_valuesCl.length; i++) {
      if(_valuesCl[i]==_valueClString) {
        _clubId = _valuesIdCl[i];
      }
    }
    print('Historial: ' + _controllerHistorial.text + ' Bio: ' + _controllerBio.text);
    _saveData(new SignUpPost(_id,_name, _surname, _email, _password, _sexo, _fecha, _nacionalidad,_localiadad, _posicion, _pierna, _altura, _peso,_historial,_bio,_clubId));
  }

  void _perfomPhoto() {
    if(base64Image==null) {
      base64Image = globals.fotoPorDefectoUser;
    }
    _savePhoto(new PhotoPost(token,base64Image));
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Welcome(_name)));
  }

  Future _savePhoto(PhotoPost data)async {
    var json = jsonCodec.encode(data);
    print("json=$json");
    var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/imageUpload";
    var response = await http.post(
      url,
      headers:{ "Accept": "application/json" } ,
      body: { "json": '$json'},
      encoding: Encoding.getByName("utf-8")
    );
    print("Response:");
    print(response.body);
  }

  Future<File> _imageFile;
  var base64Image;
  
  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Future _saveData(SignUpPost data)async {
    var json = jsonCodec.encode(data);
    print("json=$json");
    var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/user";
    var response = await http.post(
      url,
      headers:{ "Accept": "application/json" } ,
      body: { "json": '$json'},
      encoding: Encoding.getByName("utf-8")
    );
    print("Response:");
    print(response.body);
    infoJson = jsonCodec.decode(response.body);
    status = (infoJson["status"]);
    token = (infoJson["data"]);
    globals.tokenPerUser = token;
    _perfomPhoto();
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
                      value: 1.0,
                    ),
                    new Text('Club Actual?',
                      style: new TextStyle(
                        color: color_signup_button,
                        fontSize: 20.0,
                      ),
                    ),
                    new DropdownButton(
                      value: _valueClString,
                      items: _valuesCl.map((String value){
                        return new DropdownMenuItem(
                          value: value,
                          child: new Row(
                            children: <Widget>[
                              new Text('$value',
                                style: new TextStyle(
                                  fontSize: 10.0,
                              ),
                            ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String value){_onChangedCl(value);},
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new TextField(
                      controller: _controllerHistorial,
                      maxLength: 200,
                      maxLines: 4,
                      decoration: new InputDecoration(
                        //hintText: "Introduce Bio",
                        labelText: "* Introduce Historial",
                        ),
                      keyboardType: TextInputType.text,
                    ),
                    new TextField(
                      controller: _controllerBio,
                      maxLength: 200,
                      maxLines: 4,
                      decoration: new InputDecoration(
                        //hintText: "Introduce Bio",
                        labelText: "* Introduce Bio",
                        ),
                      keyboardType: TextInputType.text,
                    ),
                    new Row(
                      children: <Widget>[
                        new Text('* Introduce foto?',
                        style: new TextStyle(
                            color: color_signup_button,
                            fontSize: 20.0,
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.photo_library),
                          tooltip: 'Pick Image from gallery',
                          onPressed: () => _onImageButtonPressed(ImageSource.gallery),
                          ),
                      ],
                    ),
                    new Center(
                      child: new FutureBuilder<File>(
                        future: _imageFile,
                        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                                //foto a bytes
                                File imageFile = new File(snapshot.data.path);
                                List<int> imageBytes = imageFile.readAsBytesSync();
                                base64Image = base64Encode(imageBytes);
                            return new Image.file(snapshot.data);
                          } else if (snapshot.error != null) {
                            return const Text('error picking image.');
                          } else {
                            return const Text('Aún no has elegido una imagen.');
                          }
                        },
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new Text('* Campos opcionales'),
                    new Text('Clica a saltar para completarlos luego.'),
                    new FlatButton(
                      onPressed: _submit,
                      child: new Text('Saltar',
                        style: new TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15.0,),
                          )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new MaterialButton(
                      color: color_signup_button,
                      textColor: color_icon_text,
                      child: new Text("Finalizar"),
                      onPressed: _submit,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 5.0),),
                    new MaterialButton(
                      color: Colors.blueGrey,
                      textColor: color_icon_text,
                      child: new Text("Atras"),
                      onPressed: () {Navigator.pop(context);},
                    ),
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
