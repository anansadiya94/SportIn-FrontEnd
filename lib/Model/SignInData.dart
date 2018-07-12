class SignInData {
  String _email;
  String _pass;

  SignInData(this._email,this._pass);

  Map toJson() {
    return {"email" : _email,"password" : _pass};
  }
}