class NotificationPost {
  int _reactedId;
  int _interested;

  NotificationPost(this._reactedId,this._interested);

  Map toJson() {
    return {"reactedAnnouncementId" : _reactedId,"interested" : _interested};
  }
}