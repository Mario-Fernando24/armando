import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'menuLateral/menuprincial.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perfil",
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText("Nombre"),
            SizedBox(
              height: 4,
            ),
            AutoSizeText(
              "Startogoejemplo",
              style: _style(),
            ),
            SizedBox(
              height: 16,
            ),
            AutoSizeText(
              "Email",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            AutoSizeText("Startogoejemplo@gmail.com"),
            SizedBox(
              height: 16,
            ),
            AutoSizeText(
              "Location",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            AutoSizeText("New York, USA"),
            SizedBox(
              height: 16,
            ),
            AutoSizeText(
              "Language",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            AutoSizeText("English, French"),
            SizedBox(
              height: 16,
            ),
            AutoSizeText(
              "Occupation",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            AutoSizeText("Employee"),
            SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

final String url = "https://www.startogoweb.com/tienda/logoapp.png";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: Colors.green, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                AutoSizeText(
                  "Perfil Drive",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AutoSizeText(
                      "Startogo",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Pendientes",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "0",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Entregado",
                      style: TextStyle(color: Colors.white),
                    ),
                    AutoSizeText(
                      "0",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    AutoSizeText(
                      "Hoy",
                      style: TextStyle(color: Colors.white),
                    ),
                    AutoSizeText(
                      "0",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //      Column(
                //       children: <Widget>[
                //          Text(
                //          "Savings",
                //         style: TextStyle(color: Colors.white),
                //      ),
                //        Text(
                //         "20K",
                //        style: TextStyle(color: Colors.white, fontSize: 24),
                //     )
                //      ],
                //    ),
                SizedBox(
                  width: 32,
                ),
                //  Column(
                //     children: <Widget>[
                //    Text(
                //      "July Goals",
                //      style: TextStyle(color: Colors.white),
                //    ),
                //     Text("50K",
                //          style: TextStyle(color: Colors.white, fontSize: 24))
                //    ],
                //  ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  print("//TODO: button dd");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                  child: Transform.rotate(
                    angle: (math.pi * 0.05),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(
                        child: AutoSizeText("Editar Perfil"),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
