import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/friends/friend.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/frienddetails/friend_details_page.dart';

class Notificaciones extends StatefulWidget { 
  @override
  NotificacionesState createState() => new NotificacionesState();
}

class NotificacionesState extends State<Notificaciones> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull("http://18.218.97.74/sportin-web/symfony/web/app_dev.php/reactedannouncementnotification/$token"),
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
              return new NotificacionesData(json);
            }
          }
        )
      ),
    );
  }
}

class NotificacionesData extends StatelessWidget {
  final List data;
  NotificacionesData(this.data);

  final List<String> _nombre = new List<String>();
  final List<String> _oferta = new List<String>();
  final List<String> _photo = new List<String>();
  final List<int> _i = new List<int>();
  
  @override
  Widget build(BuildContext context){

    for(int i=0; i<data.length; i++) {
      _nombre.add(data[i]['userName']);
      _oferta.add(data[i]['description']);
      _photo.add(data[i]['profilePhoto']);
      _i.add(i);
    }

    void _popUp(int index) async{
      List<String> _nombre = new List<String>();
      List<String> _bio = new List<String>();
      List<String> _historial = new List<String>();
      List<String> _reactedId = new List<String>();
      List<String> _userId = new List<String>();
      List <String> _photoPopIp = new List<String>();

      _nombre.add(data[index]['userName']);
      _bio.add(data[index]['bio']);
      _historial.add(data[index]['historial']);
      _reactedId.add(data[index]['reactedAnnouncementId']);
      _userId.add(data[index]['userId']);
      _photoPopIp.add(data[index]['photo']);
    
      Friend friend = new Friend(
        avatar: data[index]['profilePhoto'], 
        name: data[index]['userName'], 
        surname:data[index]['surname'] , 
        bio:data[index]['bio'],  
        email: null, 
        location: data[index]['populationName'], 
        id:data[index]['userId'], 
        rol: data[index]['roleId'], 
        edad: data[index]['birthDate'], 
        sexo:data[index]['sex'], 
        pierna: data[index]['foot'], 
        peso:data[index]['weight'], 
        altura: data[index]['height'],
        position: data[index]['playerPositionName'], 
        photoPosition: data[index]['photoPosition'], 
        historial:data[index]['historial'], 
        nacionalidad:data[index]['countryName']
      );
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (c) {
            return new FriendDetailsPage(friend, 'otro', data[index]['reactedAnnouncementId'],  avatarTag: 1,);
          },
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notificaciones"),
        automaticallyImplyLeading: false, 
        backgroundColor: color_appbar,
      ),
      backgroundColor: color_background,
      body: new ListView.builder(
        itemCount: _nombre.length,
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
                    subtitle: new Text('A ${_nombre[index]} le ha interesado tu oferta -${_oferta[index]}-, clica a Ver perfil para ver su perfil.',),
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(left: 55.0),
                        child: new FlatButton(
                          onPressed: () {_popUp(_i[index]);},
                          child: new Text('Ver perfil',
                            style: new TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20.0,),
                              )
                        ),
                      )
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

