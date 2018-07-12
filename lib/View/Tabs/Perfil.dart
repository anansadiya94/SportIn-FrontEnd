import 'dart:async';
import 'dart:convert';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/View/Iniciar_sesion.dart';
import 'package:sportin/View/Globals.dart' as globals;
import 'package:sportin/View/Tabs/Perfil/MisOfertas.dart';
import 'package:sportin/View/Tabs/Perfil/MisContactos.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => new _PerfilState();

}

class _PerfilState extends State<Perfil> {
  var token = globals.tokenPerUser;
  Future<http.Response> _response;

  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _response = http.get(
        Uri.encodeFull(globals.url+"user/$token"),
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
              List json = jsonCodec.decode(response.data.body);
              return new UserData(json);
            }
          }
        )
      ),
    );
  }
}

class UserData extends StatelessWidget {
  final List data;
  UserData(this.data);
  
  Widget build(BuildContext context) {
    
    Widget photoSection =  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: 150.0,
          height: 150.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new MemoryImage(base64Decode(data[0]['profilePhoto'])),
            ),
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        )
      ],
    );

    Widget nacionalidad =  new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 30.0,
          width: 30.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/nacionalidad.png'),
            ),
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['countryName']} ⎢')
      ],
    );

    Widget localidad =  new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 30.0,
            width: 30.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/localidad.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['populationName']} ⎢')
      ],
    );

    Widget nameSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          new Text(
            '${data[0]['userName']}',// ${data[0]['surname']}
            style: new TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ) 
    );
    
    Widget clubSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Equipo actual',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text(
            '${data[0]['ClubName']}',
            style: new TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
    
    Widget positionSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Posición',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text('${data[0]['playerPositionName']}',
            style: new TextStyle(
              color: Colors.grey[500],
            ),
            softWrap: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 75.0,
                height: 75.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    image: new MemoryImage(base64Decode(data[0]['photoPosition'])),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

    Widget descriptionSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Bio',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text('${data[0]['bio']}',
            style: new TextStyle(
              color: Colors.grey[500],
            ),
            softWrap: true,
          ),
        ],
      ),
    );

    Widget biographySection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              'Historial',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text('${data[0]['historial']}',
            style: new TextStyle(
              color: Colors.grey[500],
            ),
            softWrap: true,
          ),
        ],
      ),
    );

    Widget altura = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 30.0,
            width: 30.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/altura.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['height']} cm ⎢')
      ],
    );
    
    Widget peso = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 30.0,
            width: 30.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/peso.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['weight']} kg ⎢')
      ],
    );

    Widget sexo = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 30.0,
            width: 30.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/sex.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['sex']} ⎢')
      ],
    );

    Widget pierna = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 30.0,
            width: 30.0,
          ),
          alignment: Alignment.bottomLeft,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/foot.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Text('⎢ ${data[0]['foot']} ⎢')
      ],
    );
    Widget buttonSection = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Column(
            children: <Widget>[
              new Icon(Icons.call),
              new FlatButton(
                onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new MisContactos()));},
                child: new Text('Mis Contactos',
                  style: new TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15.0,),
                    )
              ),
            ],
          ),
          new Column(
            children: <Widget>[
              new Icon(Icons.assignment),
              new FlatButton(
                onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new MisOfertas()));},
                child: new Text('Mis Ofertas',
                  style: new TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15.0,),
                    )
              ),
            ],
          ),
        ],
      ),
    );

    Future _saveData() async {
      var token = globals.tokenPerUser;
      
      var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/deactivateuser";
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
      Navigator.push(context,new MaterialPageRoute(builder: (context) => new Login()));
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
    Widget vacio = new Text('');

    Widget alturaN() {
      if(data[0]['height']!=null) {
        return altura;
      }
      else return vacio;
    } 

    Widget pesoN() {
      if(data[0]['weight']!=null) {
        return peso;
      }
      else return vacio;
    } 

    Widget sexoN() {
      if(data[0]['sex']!=null) {
        return sexo;
      }
      else return vacio;
    } 

    Widget piernaN() {
      if(data[0]['foot']!=null) {
        return pierna;
      }
      else return vacio;
    } 

    Widget clubN() {
      String club = data[0]['clubId'];
      int idClub = int.parse('$club');
      if(idClub!=1) {
        return clubSection;
      }
      else return vacio;
    } 

    Widget positionN() {
      String position = data[0]['playerPositionId'];
      int idPosition = int.parse('$position');
      assert(idPosition is int);
      if(idPosition!=100) {
        return positionSection;
      }
      else return vacio;
    } 

    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Perfil"), 
        automaticallyImplyLeading: false,
        backgroundColor: color_appbar,
      actions: <Widget>[
        new PopupMenuButton(
          itemBuilder: (_) => <PopupMenuItem<GestureDetector>>[
            new PopupMenuItem<GestureDetector>(
              child: new GestureDetector(
                onTap: _deActivate,
                child: new Row(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.cancel),
                      tooltip: 'Desactivar',
                      onPressed: () {
                          _deActivate();
                        },
                    ),
                    new Text('Desactivar cuenta'),
                  ],
                )
              ), 
            ),
            new PopupMenuItem<GestureDetector>(
              child: new GestureDetector(
                onTap: _exit,
                child: new Row(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.exit_to_app),
                      tooltip: 'Log out',
                      onPressed: () {
                          _exit();
                        },
                    ),
                    new Text('Cerrar sesión'),
                  ],
                ),
              )
            ),
          ],
        ),
        ],
      ),
      body: new ListView(
        children: [
          photoSection,
          nameSection,
          new Row(
            children: <Widget>[
              nacionalidad,
              localidad,
            ],
          ),
          new Row(
            children: <Widget>[
              alturaN(),
              pesoN(),
              sexoN(),
              piernaN(),
            ],
          ),
          buttonSection,
          clubN(),
          positionN(),
          descriptionSection,
          biographySection,
        ],
      ),
    );
  }
}
