import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startogodomiciliario/view/login.dart';
import 'package:startogodomiciliario/view/utilities/screenUtilCalc.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 35.0 : 35.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo[900] : Color(0xFF7B4344),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: calcFromH(context, 0.03)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage())),
                    child: SizedBox(
                        width: calcFromW(context, 0.15),
                        height: calcFromH(context, 0.06),
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Saltar',
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 24.0,
                            ),
                          ),
                        )),
                  ),
                ),
                Container(
                  height: calcFromH(context, 0.96) - 100,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0,
                            horizontal: calcFromH(context, 0.03)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage('assets/apk1.png'),
                                height: calcFromH(context, 0.6),
                                width: calcFromW(context, 0.8),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText('Bienvenidos a Startogo Driver',
                                style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            AutoSizeText(
                              'Con nuestra Aplicación usted puede comenzar a recibir y llevar pedidos en tiempo real.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage('assets/drivers.png'),
                                height: calcFromH(context, 0.6),
                                width: calcFromW(context, 0.8),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            // Text(
                            //   'Aplicacion \nDomiciliario!',
                            //   style: kTitleStyle,
                            //  ),
                            //   SizedBox(height: 15.0),
                            //   Text(
                            //    'serán capaces de ordenar recibir,,,,,,, faltaaa.',
                            //    style: kSubtitleStyle,
                            //  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                AutoSizeText(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: calcFromW(context, 0.045),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: calcFromW(context, 0.01)),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.green[900],
                                  size: calcFromW(context, 0.065),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : AutoSizeText(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
