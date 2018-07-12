class PhotoPost {
  String _token;
  String _base64;
  
  PhotoPost(this._token,this._base64);

  Map toJson() {
    return {"token" : _token,"image" : _base64};
  }
}