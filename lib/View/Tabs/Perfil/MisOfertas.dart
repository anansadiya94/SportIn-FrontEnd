import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/Model/ModifyOfferPost.dart';
import 'package:sportin/View/Globals.dart' as globals;

class MisOfertas extends StatefulWidget { 
  @override
  MisOfertasState createState() => new MisOfertasState();
}

class MisOfertasState extends State<MisOfertas> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;
  
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    var url = globals.url+"announcementPerUser/"+token;
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
              return new MiOfertassData(json);
            }
          }
        )
      ),
    );
  }
}

class MiOfertassData extends StatelessWidget {
  final List data;
  MiOfertassData(this.data);

  final List<String> _title = new List<String>();
  final List<String> _annId = new List<String>();

  @override
  Widget build(BuildContext context){
    
    for(int i=0; i<data.length; i++) {
      _title.add(data[i]['title']);
      _annId.add(data[i]['announcementId']);
    }

    Future _saveData(ModifyOfferPost data) async {
      var json = jsonCodec.encode(data);
      var token = globals.tokenPerUser;
      var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/modifyannouncement";
      var response = await http.post(
        url,
        headers:{ "Accept": "application/json" } ,
        body: {"token" : '$token',"json": '$json'},
        encoding: Encoding.getByName("utf-8")
      );
      print("Response:");
      print(response.body);
    }

    void _exit() {
      Navigator.of(context).pop(null);
    }

    void _seguro(int id) {
      _saveData(new ModifyOfferPost(id));
      _exit();
    }

    Future<String> _popUp(int id) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
          title: Text('Eliminar oferta'),
            content: new Text('¿Estás seguro que quieres eliminar esta oferta?'),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.close),
                color: Colors.blue,
                iconSize: 50.0,
                tooltip: 'Intentar otro',
                onPressed: () {Navigator.pop(context);},
              ),
              new IconButton(
                icon: new Icon(Icons.check),
                color: Colors.blue,
                iconSize: 50.0,
                tooltip: 'Intentar otro',
                onPressed: () {_seguro(id);},
              ),
            ],
          );
        }
      );
    }

    void _deActivate(String idString) {
      int id = int.parse('$idString');
      assert(id is int);
      _popUp(id);
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mis Ofertas"),
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
        itemCount:_title.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              padding: new EdgeInsets.only(bottom:50.0),
              child:new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Text('${_title[index]}',
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.clear,color: Colors.red[500],),
                    onPressed: () {_deActivate(_annId[index]);},
                  ),
                ]
              ),
            ),     
          );
        }
      ),
    );
  }
}
