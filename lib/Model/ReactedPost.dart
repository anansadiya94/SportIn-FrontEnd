class ReactedPost {
  int _announcementId;

  ReactedPost(this._announcementId);

  Map toJson() {
    return {"announcementId" : _announcementId};
  }
}