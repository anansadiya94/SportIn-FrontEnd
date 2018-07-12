import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/Model/OfferPost.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportin/View/Globals.dart' as globals;

class CrearOfertaE extends StatefulWidget { 
  final int _searchedRoleId;
  CrearOfertaE(this._searchedRoleId);
  @override
  CrearOfertaEState createState() => new CrearOfertaEState(_searchedRoleId);
}

class CrearOfertaEState extends State<CrearOfertaE> {
  var token = globals.tokenPerUser;
  final int _searchedRoleId;
  CrearOfertaEState(this._searchedRoleId);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _controllerD = new TextEditingController();
  final TextEditingController _controllerT = new TextEditingController();
  int _categoryId = 2;
  
  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print(' Título: ' + _controllerT.text + ' Descripción: ' + _controllerD.text);
      if(base64Image==null) {
        base64Image = globals.fotoPorDefectoOferta;
      }
      _saveData(new OfferPost(_controllerT.text,_controllerD.text,_categoryId,_searchedRoleId,base64Image));
    }
  }

  Future<File> _imageFile;
  var base64Image;
  
  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Future _saveData(OfferPost data)async {
    var json = jsonCodec.encode(data);
    print("token=$token, json=$json");
    print(data);
    var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/announcement";
    var response = await http.post(
      url,
      headers:{ "Accept": "application/json" } ,
      body: {"token" : '$token',"json": '$json'},
      encoding: Encoding.getByName("utf-8")
    );
    print("Response:");
    print(response.body);
    Navigator.of(context).pushNamed("/tabs");
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
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text('Crear oferta', style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                    new Text('En busqueda de entrenador', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                    new TextFormField(
                      controller: _controllerT,
                      maxLength: 45,
                      maxLines: 2,
                      decoration: new InputDecoration(
                        labelText: "Introduce Titulo",
                      ),
                      validator: (val) {
                        if(val.length==0) {return 'Campo obligatorio, introduce título.';}
                        if(val.length<5) {return 'Titulo demasiado corto, mínimo 5.';}
                        if(val.length>45) {return 'Titulo demasiado largo, máximo 45.';}
                      },
                      keyboardType: TextInputType.text,
                    ),
                    new TextFormField(
                      controller: _controllerD,
                      maxLength: 200,
                      maxLines: 4,
                      decoration: new InputDecoration(
                        //hintText: " ",
                        labelText: "Introduce descripción",
                      ),
                      validator: (val) {
                        if(val.length==0) {return 'Campo obligatorio, introduce descripción.';}
                        if(val.length<15) {return 'Descripción demasiado corta, mínimo 15.';}
                        if(val.length>200) {return 'Descripción demasiado larga, máximo 200.';}
                      },
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
                    new MaterialButton(
                      color: color_signup_button,
                      textColor: color_icon_text,
                      child: new Text("Subir oferta"),
                      onPressed: _submit,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 5.0),),
                    new MaterialButton(
                      color: Colors.blueGrey,
                      textColor: color_icon_text,
                      child: new Text("Cancelar"),
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