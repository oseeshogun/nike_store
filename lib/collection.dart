import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nike_app/chaussures.dart';

import 'details.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  final _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New collection",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => _drawerController.toggle!(),
                    child: Image.asset("images/menu.png"),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TabItem(
                          "Men",
                          active: true,
                        ),
                        TabItem("Women"),
                        TabItem("Kids"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search...",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    childAspectRatio: .7,
                  ),
                  itemCount: chaussures.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Chaussure chaussure = chaussures[index];
                    return ChaussureItem(chaussure: chaussure, index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    var drawer = Scaffold(
      backgroundColor: Color(0xffa3e157),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      AssetImage("images/sam-burriss-tV_1sC603zA-unsplash.jpg"),
                ),
                const SizedBox(width: 15.0),
                Text(
                  "Tom Martins",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const Spacer(),
            DrawerItem("New collection", active: true),
            DrawerItem("Catalogue"),
            DrawerItem("Your cart"),
            DrawerItem("Favorites"),
            DrawerItem("Settings"),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black45,
                ),
                const SizedBox(width: 20),
                Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return ZoomDrawer(
      style: DrawerStyle.Style1,
      mainScreen: scaffold,
      menuScreen: drawer,
      showShadow: true,
      borderRadius: 24.0,
      angle: 0.0,
      backgroundColor: Colors.black26,
      controller: _drawerController,
      slideWidth:
          MediaQuery.of(context).size.width * (ZoomDrawer.isRTL() ? .45 : .65),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
    this.text, {
    this.active = false,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: active ? Border(bottom: BorderSide(width: 2)) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: active ? Colors.black : Colors.black45,
        ),
      ),
    );
  }
}

class ChaussureItem extends StatelessWidget {
  const ChaussureItem({
    Key? key,
    required this.chaussure,
    required this.index,
  }) : super(key: key);

  final Chaussure chaussure;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, index.isOdd ? 40.0 : 0.0),
      child: Container(
        margin: index.isEven
            ? EdgeInsets.only(top: 40, right: 30)
            : EdgeInsets.only(
                top: 40,
                right: 10,
                left: 20,
              ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(chaussure)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Hero(
                        tag: chaussure.name,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..rotateZ(-40 * (math.pi / 180)),
                          child: Transform.translate(
                            offset: Offset(-50, -45),
                            child: Transform(
                              transform: Matrix4.identity()..scale(1.3),
                              child: Image.asset(
                                chaussure.asset,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              chaussure.name,
              style: TextStyle(
                color: Colors.white.withOpacity(.7),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "\$ " + chaussure.price.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffa3e157),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem(
    this.text, {
    this.active = false,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: active
              ? BorderSide(
                  color: Colors.white,
                  width: 3,
                )
              : BorderSide(style: BorderStyle.none),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.white.withOpacity(.5),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
