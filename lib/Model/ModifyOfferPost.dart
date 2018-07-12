class ModifyOfferPost {
  int _idAnn;

  ModifyOfferPost(this._idAnn);

  Map toJson() {
    return {"announcementId" : _idAnn};
  }
}
