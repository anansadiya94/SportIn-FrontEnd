class SignUpPost {
  int _id;
  String _nameU;
  String _surnameU;
  String _emailU;
  String _passwordU;
  String _sexU;
  int _position;
  String _foot;
  var _height;
  var _weight;
  String _historial;
  String _bio;
  String _birthday;
  int _countryID;
  int _populationID;
  int _clubId;

  SignUpPost(this._id,this._nameU,this._surnameU,this._emailU,this._passwordU,this._sexU, this._birthday
            ,this._countryID,this._populationID,this._position,this._foot,this._height,this._weight
            ,this._historial,this._bio,this._clubId);

  Map toJson() {
    return {"roleId" : _id,"username" : _nameU, "surname" : _surnameU,"email" : _emailU,
    "password" : _passwordU,"active" : 1,"birthDate" : _birthday,"age" : 21,
    "countryId" : _countryID,"populationId" : _populationID,"height" : _height,
    "weight" : _weight,"bio" : _bio, "sex" : _sexU, "foot" : _foot,
    "playerPositionId": _position, "historial":_historial, "clubId":_clubId};
  }
}