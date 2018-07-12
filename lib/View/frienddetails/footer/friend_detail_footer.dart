import 'package:flutter/material.dart';
import 'package:sportin/View/frienddetails/footer/skills_showcase.dart';
import 'package:sportin/View/frienddetails/footer/articles_showcase.dart';
import 'package:sportin/View/friends/friend.dart';

class FriendShowcase extends StatefulWidget {
  FriendShowcase(this.friend);

  final Friend friend;

  @override
  _FriendShowcaseState createState() => new _FriendShowcaseState(this.friend);

}

class _FriendShowcaseState extends State<FriendShowcase>
    with TickerProviderStateMixin {
  _FriendShowcaseState(this.friend);
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;
  final Friend friend;

  @override
  initState() {
    super.initState();
    _tabs = [
      new Tab(text: 'Personal'),
      new Tab(text: 'Historial'),
    ];
    _pages = [
      new SkillsShowcase(this.friend),
      new ArticlesShowcase(this.friend),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: new Column(
        children: [
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
