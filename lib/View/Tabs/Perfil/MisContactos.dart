import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Globals.dart' as globals;

class MisContactos extends StatefulWidget { 
  @override
  MisContactosState createState() => new MisContactosState();
}

class MisContactosState extends State<MisContactos> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/contact/"+token;
    print(url);
    setState(() {
      _response = http.get(
        url,
        headers : {
          "Accept": "application/json"
        }
      );
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: _refresh,
      ),
      body: new Center(
        child: new FutureBuilder(
          future: _response,
          builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData)
              return new Text('Loading...');
            else if (response.data.statusCode != 200) {
              return new Text('Could not connect to User service.');
            } else {
              List json = jsonCodec.decode((response.data.body));
              return new MisContactosData(json);
            }
          }
        )
      ),
    );
  }
}

class MisContactosData extends StatelessWidget {
  final List data;
  MisContactosData(this.data);

  final List<String> _nombre = new List<String>();
  final List<String> _correo = new List<String>();
  final List<String> _photo = new List<String>();

  @override
  Widget build(BuildContext context){

    for(int i=0; i<data.length; i++) {
      _nombre.add(data[i]['userName']);
      _correo.add(data[i]['email']);
      _photo.add(data[i]['profilePhoto']);
    }

  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Mis Contactos"),
      automaticallyImplyLeading: false, 
      backgroundColor: color_appbar,
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(null),
        ),
      ],
    ),
    backgroundColor: color_background,
    body: new ListView.builder(
      itemCount:_nombre.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new Container(
            padding: new EdgeInsets.all(15.0),
            child: new Column(
              children: <Widget>[
                new ListTile(
                  onTap: null,
                  leading: new Hero(
                    tag: index,
                    child: new CircleAvatar(
                      backgroundImage: new MemoryImage(base64Decode(_photo[index])),
                    ),
                  ),
                  title: new Text('${_nombre[index]}', style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                ),
                new Row(
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {Navigator.of(context).pushNamed("/crear_oferta");},
                      child: new Text('${_correo[index]}',
                        style: new TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20.0,),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ), 
    );
  }
}
