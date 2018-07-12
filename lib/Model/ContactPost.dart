class ContactPost {
  int _idUser;

  ContactPost(this._idUser);

  Map toJson() {
    return {"contact_userId" : _idUser};
  }
}
