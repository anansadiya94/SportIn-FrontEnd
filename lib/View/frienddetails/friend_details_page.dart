import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:sportin/View/friends/friend.dart';
import 'package:sportin/View/frienddetails/friend_detail_body.dart';
import 'package:sportin/View/frienddetails/header/friend_detail_header.dart';
import 'package:sportin/View/frienddetails/footer/friend_detail_footer.dart';

class FriendDetailsPage extends StatefulWidget {
  FriendDetailsPage(
    this.friend, this.mode, this.reacted,{
    @required this.avatarTag
    });
  final Friend friend;
  final String mode;
  final Object avatarTag;
  final String reacted;

  @override
  _FriendDetailsPageState createState() => new _FriendDetailsPageState(this.reacted, this.mode);
}


class _FriendDetailsPageState extends State<FriendDetailsPage> {
  _FriendDetailsPageState(this.reacted, this.mode);
  final String reacted;
  final String mode;

  @override
  Widget build(BuildContext context) {
    var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: [
          const Color(0xFF0066ff),//0xFF413070
          const Color(0xFF2B264A),
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new FriendDetailHeader(
                widget.friend,
                this.mode,
                this.reacted,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new FriendDetailBody(widget.friend),
              ),
              new FriendShowcase(widget.friend),
            ],
          ),
        ),
      ),
    );
  }
}
