class OfferPost {
  String _title;
  String _description;
  bool _active=true;
  bool _modified=true;
  int _categoryID;
  int _searchedRoleId;
  String _base64;

  OfferPost(this._title,this._description,this._categoryID,this._searchedRoleId,this._base64);

  Map toJson() {
    return {"title" : _title,"description" : _description,"active" : _active, "modified" : _modified,
    "categoryId":_categoryID,"positionId" : '1',"searchedRoleId":_searchedRoleId,"image" : _base64};
  }
}
