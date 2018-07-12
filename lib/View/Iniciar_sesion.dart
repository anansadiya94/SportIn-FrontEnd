import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sportin/Estilo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportin/Model/SignInData.dart';
import 'package:sportin/View/Globals.dart' as globals;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  Map infoJson;
  String status;
  String token;

  //1
  void _submit() async{
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _performLogin();
    }
    //get de roles para pestaña crear oferta jugador
    var _responseD = await http.get(
    Uri.encodeFull("http://18.218.97.74/sportin-web/symfony/web/app_dev.php/position"),
      headers : {
        "Accept": "application/json"
      }
    );
    globals.populationsG = jsonCodec.decode((_responseD.body));
    for(int i=0; i<globals.populationsG.length; i++) {
      globals.positionsGS.add(globals.populationsG[i]['name']);
      globals.idPositionsG.add(globals.populationsG[i]['playerpositionid']);
    }
  }

  void encriptar(String val){
    var bytes = utf8.encode(val); // data being hashed
    var digest = sha1.convert(bytes);  
    _passcif = '$digest';
  }

  //2
  String _passcif;
  void _performLogin() {
    print('Correo: ' + _getmail() + ' Contraseña: ' +_getpass());
    encriptar(_getpass());
    _saveData(new SignInData(_getmail(),_passcif));
  }

  //3
  Future _saveData(SignInData data) async {
    var json = jsonCodec.encode(data);
    print("json=$json");
    var url = "http://18.218.97.74/sportin-web/symfony/web/app_dev.php/login";
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
    if(status == 'error') {
      signInError(status);
    }else if (status == 'deActivated') {
      _showSnackBar('Cuenta desactivada. Contacta con nosotros para activarla.');
    }else{
      token = (infoJson["data"]);
      globals.tokenPerUser = token;
      signInSucces(status,token);
    }
  }

  void signInError(String code) {
    print ("-----------");
    print(code);
    print('Correo i/o contraseña incorrectos');
    _showSnackBar('Correo i/o contraseña incorrectos, inténtalo otra vez');
  }

  void signInSucces(String code, String token) {
    print ("-----------");
    print(code);
    print(token);
    print('Se ha registrado correctamente');
    Navigator.of(context).pushNamed("/tabs");
  }

  String _getmail(){
    return this._email;
  }

  String _getpass(){
    return this._password;
  }

  void _showSnackBar(String txt) {
    _scaffoldstate.currentState.showSnackBar(new SnackBar(
      content: new Text(txt, style: new TextStyle(fontSize: 20.0),),
      backgroundColor: color_snackbar,
    ),);
  }
  
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      key:_scaffoldstate,
      backgroundColor: color_background,
      body: new Form(
        key: formKey,
        child: new Theme(
          data: new ThemeData(
            inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(
              color: color_login_button,
              fontSize: 20.0,
              )
            )
          ),
          child: new Container(
            padding: const EdgeInsets.all(40.0),//pading del textfield
            child: new ListView(
              children: [
                new Padding(padding: const EdgeInsets.all(40.0)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Image(
                      height: 200.0,
                      width: 200.0,
                      image: new AssetImage("assets/icono_1.png"),
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(labelText: 'Correo electrónico', /*prefixText: 'Zlatan@gmail.com',*/ icon: const Icon(Icons.mail_outline),),
                      style: new TextStyle(color: color_filltext),
                      onSaved: (val) => _email = val,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(labelText: 'Contraseña', /*prefixText: 'Zlatan',*/ icon: const Icon(Icons.lock_open),),
                      style: new TextStyle(color: color_filltext),
                      onSaved: (val) => _password = val,
                      obscureText: true,
                    ),
                      new Padding(padding: new EdgeInsets.all(10.0),),
                      new InkWell(
                        child: new Text('Crear cuenta Registrarse aquí'),
                        onTap: () => Navigator.of(context).pushNamed("/signup"),
                      ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),),
                    new MaterialButton(
                      color: color_login_button,
                      textColor: color_icon_text,
                      child: new Text("Iniciar sesión"),
                      onPressed: _submit,
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
