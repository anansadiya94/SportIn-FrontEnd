import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Portada.dart';
import 'package:sportin/Model/ContactPost.dart';
import 'package:sportin/View/friends/friend.dart';
import 'package:sportin/Model/NotificationPost.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Tabs/Perfil/MisOfertas.dart';
import 'package:sportin/View/Tabs/Perfil/MisContactos.dart';
import 'package:sportin/View/frienddetails/header/diagonally_cut_colored_image.dart';

class FriendDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/jugador.jpg';

  FriendDetailHeader(
    this.friend, this.mode, this.reacted, {
    @required this.avatarTag,
  });

  final Friend friend;
  final Object avatarTag;
  final String reacted;
  final String mode;

  _createPillButton(
    int code,
    BuildContext context,
    String mode, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
  }) {
    String text = '';
    if(mode=='otro'){
      text = code==2 ? 'Aceptar' : 'Rechazar';
    }

    if (mode=='mio'){
    text = code==2 ? 'Mis contactos' : 'Mis ofertas';
    }

     if (mode=='ver'){
    text = code==2 ? 'Agregar' : 'Seguir';
    }
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {
          if(mode=='otro'){
          _submit(this.reacted, code, this.friend.id);}
          if(mode =='mio'){
            if(code==2){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new MisContactos()));
            }else{
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new MisOfertas()));
            }
          }
        },
        child: new Text(text),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var followerStyle = textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF)); //0xBBFFFFFF
    var screenWidth = MediaQuery.of(context).size.width;
    var diagonalBackground = new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB6699ff),//0xBB8338f4
    );

    var avatar = new Hero(
      tag: avatarTag,
      child: new CircleAvatar(
       backgroundImage: new MemoryImage(base64Decode(friend.avatar)),
        radius: 50.0,
      ),
    );

    Future _saveData() async {
      var token = globals.tokenPerUser;
      var url = globals.url+"deactivateuser";
      var response = await http.post(
        url,
        headers:{ "Accept": "application/json" } ,
        body: { "token": '$token'},
        encoding: Encoding.getByName("utf-8")
      );
      print("Response:");
      print(response.body);
    }

    void _exit() {
      Navigator.push(context,new MaterialPageRoute(builder: (context) => new Portada()));
    }

    void _seguro() {
      _saveData();
      _exit();
    }

    Future<String> _popUp() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
          title: Text('Desactivar cuenta'),
            content: new Text('¿Estás seguro que quieres desactivar tu cuenta?'),
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
                onPressed: _seguro,
              ),
            ],
          );
        }
      );
    }

    void _deActivate() {
      _popUp();
    }
    
    Widget info(){
      if(mode =='mio') {
        return new Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new GestureDetector(
              onTap: _exit,
              child: new Row(
                children: <Widget>[
                  new Text('Cerrar sesión', style: new TextStyle(color: Colors.white)),
                  new IconButton(
                    icon: new Icon(Icons.exit_to_app,color: Colors.white,),
                    tooltip: 'Log out',
                    onPressed: () {
                        _exit();
                      },
                  ),
                ],
              ),
            ),
            new Text('|',style: followerStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.normal),),
            new GestureDetector(
              onTap: _deActivate,
              child: new Row(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.cancel,color: Colors.white,),
                    tooltip: 'Desactivar',
                    onPressed: () {
                        _deActivate();
                      },
                  ),
                  new Text('Desactivar cuenta', style: new TextStyle(color: Colors.white)),
                ],
              )
            ), 
          ]
        ),
      );
      } else {
        return new Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //new Text('Contactos 6', style: followerStyle),
            //new Text(' | ',style: followerStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.normal),),
            //new Text('Ofertas 10', style: followerStyle),
          ],
        ),
      );
      }
    }

    var actionButtons = new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _createPillButton(
            2,
            context,
            this.mode,
            backgroundColor: theme.accentColor, 
          ),
          new DecoratedBox(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white30),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: _createPillButton(
              1,
              context,
              this.mode,
              textColor: Colors.white70,
            ),
          ),
        ],
      ),
    );

    return new Stack(
      children: [
        diagonalBackground,
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: [
              avatar,
              info(),
              actionButtons,
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
  void _submit(String reactedId, int interested,String userIdOferta) {
    print('----------');
    print(userIdOferta);
     print('----------');
    int id = int.parse('$reactedId');
    assert(id is int);
    int idUserOferta = int.parse(userIdOferta);
    assert(idUserOferta is int);
    print('Reacted Id : ' +id.toString()+ 'Interested: ' + interested.toString());
    _saveData(new NotificationPost(id,interested));
    if(interested==2) {
      _saveContact(new ContactPost(idUserOferta));
    }
  }

  Future _saveData(NotificationPost data)async {
    var token = globals.tokenPerUser;
    var json = jsonCodec.encode(data);
    print("json=$json");
    print(data);
    var url = globals.url+"updatereactedannouncement";
    var response = await http.post(
      url,
      headers:{ "Accept": "application/json" } ,
      body: {"token" : '$token',"json": '$json'},
      encoding: Encoding.getByName("utf-8")
    );
    print("Response:");
    print(response.body);
  }

  Future _saveContact(ContactPost data)async {
    var token = globals.tokenPerUser;
    var json = jsonCodec.encode(data);
    print("json=$json");
    print(data);
    var url = globals.url+"contact";
    var response = await http.post(
      url,
      headers:{ "Accept": "application/json" } ,
      body: {"token" : '$token',"json": '$json'},
      encoding: Encoding.getByName("utf-8")
    );
    print("Response:");
    print(response.body);
  }
}
