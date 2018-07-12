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

class RegistrarseC3 extends StatefulWidget { 
  final _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final String _sexo;
  final String _fecha;
  final int _nacionalidad;
  final int _localiadad;
  RegistrarseC3(this._id,this._name,this._surname,this._email,this._password,this._sexo,this._fecha,this._nacionalidad,this._localiadad);
  @override
  RegistrarseC3State createState() => new RegistrarseC3State(_id,_name,_surname,_email,_password,_sexo,_fecha,_nacionalidad,_localiadad);
}

class RegistrarseC3State extends State<RegistrarseC3> {
  final int _id;
  final String _name;
  final String _surname;
  final String _email;
  final String _password;
  final String _sexo;
  final String _fecha;
  final int _nacionalidad;
  final int _localiadad;
  RegistrarseC3State(this._id,this._name,this._surname,this._email,this._password,this._sexo,this._fecha,this._nacionalidad,this._localiadad);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _controllerBio = new TextEditingController();
  final TextEditingController _controllerHistorial = new TextEditingController();
  String _bio;
  String _historial;
  Map infoJson;
  String status;
  String token;

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
    print('Historial: ' + _controllerHistorial.text + ' Bio: ' + _controllerBio.text);
    _saveData(new SignUpPost(_id,_name, _surname, _email, _password, _sexo, _fecha, _nacionalidad,_localiadad, 100, null, null, null,_historial,_bio,1));
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
    var url = globals.url+"imageUpload";
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
    print(data);
    var url = globals.url+"user";
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
                    new TextField(
                      controller: _controllerHistorial,
                      maxLength: 200,
                      maxLines: 4,
                      decoration: new InputDecoration(
                        //hintText: "Trofios?",
                        labelText: "* Introduce Historial",
                        ),
                      keyboardType: TextInputType.text,
                    ),
                    new TextField(
                      controller: _controllerBio,
                      maxLength: 200,
                      maxLines: 4,
                      decoration: new InputDecoration(
                        //hintText: "",
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