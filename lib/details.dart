import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'chaussures.dart';

class Details extends StatelessWidget {
  const Details(this.chaussure, {Key? key}) : super(key: key);

  final Chaussure chaussure;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.keyboard_backspace),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          chaussure.completeName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Men's running shoe"),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: height * .5,
                          child: Hero(
                            tag: chaussure.name,
                            child: Transform.rotate(
                              angle: -math.pi / 8,
                              child: Image.asset(chaussure.asset),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            children: [
                              Text(
                                "Size",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white60),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Sizeitem("9"),
                                    Sizeitem("9.5"),
                                    Sizeitem("10", active: true),
                                    Sizeitem("10.5"),
                                    Sizeitem("11"),
                                    Sizeitem("11.5"),
                                    Sizeitem("12"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            children: [
                              Text(
                                "Color",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white60),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ColorItem(
                                      color: chaussure.color,
                                      active: true,
                                    ),
                                    ColorItem(color: Colors.white),
                                    ColorItem(color: Colors.black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      top: height * .55,
                      child: Transform(
                        transform: Matrix4.identity()..rotateX(-math.pi / 3),
                        child: CustomPaint(
                          painter: ArcPainter(chaussure.color),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.width * .9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff333333),
                ),
                height: height * .1,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ " + chaussure.price.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffa3e157),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(chaussure.color),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 40)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: chaussure.color.computeLuminance() > .5
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    Key? key,
    required this.color,
    this.active = false,
  }) : super(key: key);

  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: const EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      child: active
          ? Icon(
              Icons.done,
              color:
                  color.computeLuminance() > .5 ? Colors.black : Colors.white,
            )
          : Container(),
    );
  }
}

class Sizeitem extends StatelessWidget {
  const Sizeitem(
    this.size, {
    this.active = false,
    Key? key,
  }) : super(key: key);

  final String size;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: active ? Colors.white24 : null,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 15.0,
      ),
      alignment: Alignment.center,
      child: Text(
        size,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final Color borderColor;

  ArcPainter(this.borderColor);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 10.0);
    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: size.width * .9,
        height: size.height * .9,
      ),
      .0,
      2 * math.pi,
      false,
      paint,
    );
    canvas.drawShadow(
      Path()
        ..addOval(Rect.fromCenter(
          center: center,
          width: size.width * .3,
          height: size.height * .3,
        )),
      Colors.white.withOpacity(.2),
      1.0,
      true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
