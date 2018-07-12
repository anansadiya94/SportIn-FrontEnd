import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/Model/ReactedPost.dart';
import 'package:sportin/View/friends/friend.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/frienddetails/friend_details_page.dart';

class Home extends StatefulWidget { 
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull(globals.url+"announcement/"),
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
              return new AnnouncementData(json);
            }
          }
        )
      ),
    );
  }
}

class AnnouncementData extends StatelessWidget {
  final List data;
  AnnouncementData(this.data);

  final List<String> _title = new List<String>();
  final List<String> _description = new List<String>();
  final List<String> _nombre = new List<String>();
  final List<String> _position = new List<String>();
  final List<String> _equipoActual = new List<String>();
  final List<String> _tipoUsuario = new List<String>();
  final List <String> _userId = new List<String>();
  final List<String> _index = new List<String>();
  final List<String> _photo = new List<String>();
  final List<String> _photoAnn = new List<String>();
  final List<int> _i = new List<int>();
  final List<String> _bio = new List <String>();
  final List<String> _edad = new List <String>();

  Future _saveData(ReactedPost data)async {
    var token = globals.tokenPerUser;
    var json = jsonCodec.encode(data);
    print("json=$json");
    print(data);
    var url = globals.url+"reactedannouncement";
    var response = await http.post(
      url,
      headers:{ "Accept": "application/json" } ,
      body: {"token" : '$token',"json": '$json'},
      encoding: Encoding.getByName("utf-8")
    );
    print("Response:");
    print(response.body);
  }

  Widget build(BuildContext context) {

    void _submit(String annId) {
      int id = int.parse('$annId');
      assert(id is int);
      print(' Announcement Id : ' +id.toString());
      _saveData(new ReactedPost(id));
      Navigator.pop(context);
    }
    
    Future<String> _popUp(int index) async{

      List<String> _titlePopUp = new List<String>();
      List<String> _descriptionPopUp = new List<String>();
      List<String> _positionPopUp = new List<String>();
      List<String> _annIdPopUp = new List<String>();
      List<String> _userNamePopUp = new List<String>();
      List<String> _userPhoto = new List <String>();
      List<String> _annPhoto = new List <String>();
      _titlePopUp.add(data[index]['title']);
      _descriptionPopUp.add(data[index]['description']);
      _positionPopUp.add(data[index]['position']);
      _annIdPopUp.add(data[index]['announcementId']);
      _userNamePopUp.add(data[index]['userName']);
      _userPhoto.add(data[index]['profilePhoto']);
      _annPhoto.add(data[index]['photo']);
  
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
           title: Text('${_userNamePopUp[0]} Te busca!'),
            content: new Column(
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      constraints: new BoxConstraints.expand(
                        height: 200.0,
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new MemoryImage(base64Decode(_annPhoto[0])),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0),),
                new Text(
                  'Titulo: ${_titlePopUp[0]}',
                  style: new TextStyle(decoration: TextDecoration.underline, fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0),),
                new Text('Descripción', style: new TextStyle(decoration: TextDecoration.underline, fontSize: 20.0,),),
                new Text('${_descriptionPopUp[0]}'),
              ],
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {_submit(_annIdPopUp[0]);},
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/logo_me_interesa.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          );
        }
      );
    }

    for(int i=0; i<data.length; i++) {
      _title.add(data[i]['title']);
      _description.add(data[i]['description']);
      _position.add(data[i]['position']);
      _userId.add(data[i]['userId']);
      _index.add(data[i]['announcementId']);
      _nombre.add(data[i]['userName']);
      _photo.add(data[i]['profilePhoto']);
      _photoAnn.add(data[i]['photo']);
      _tipoUsuario.add('Entrenador');
      _equipoActual.add('MAN CITY');
      _bio.add(data[i]['bio']);
      _edad.add(data[i]['age']);
      _i.add(i);
    }
    
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Home"), 
        automaticallyImplyLeading: false,
        backgroundColor: color_appbar,
      ),
      body:new ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              padding: new EdgeInsets.all(15.0),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    onTap: (){
                      Friend friend = new Friend(
                        avatar: _photo[index], 
                        name: _nombre[index], 
                        surname: data[index]['surname'], 
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
                            return new FriendDetailsPage(friend, 'ver', '', avatarTag: 1,);
                          },
                        ),
                      );
                    },
                    leading: new Hero(
                      tag: index,
                      child: new CircleAvatar(
                        backgroundImage: new MemoryImage(base64Decode(_photo[index])),
                      ),
                    ),
                    title: new Text('${_nombre[index]}', style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        constraints: new BoxConstraints.expand(
                          height: 200.0,
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new MemoryImage(base64Decode(_photoAnn[index])),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: 
                          new Text('${_title[index]}. Clica a Leer más por si te interesa.',),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new FlatButton(
                        onPressed: () {_popUp(_i[index]);},
                          child: new Text('Leer más',
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