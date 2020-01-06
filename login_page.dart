
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


String selectedUrl =
    'https://login.unm.edu/cas/login?service=https%3A%2F%2Fwww5.unm.edu%2Fselfservice%2Fgeneral%2Flogincheck.html';

class LoginPage extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  void main() => runApp(LoginPage());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class AddLoginPage extends StatefulWidget {
  @override
  _AddLoginPage createState() => new _AddLoginPage();
}

class _AddLoginPage extends State<AddLoginPage>
    with SingleTickerProviderStateMixin {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    flutterWebViewPlugin.close();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        ClipPath(
          clipper: CustomDrawerClipper(),
          child: Material(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(80.0),
              bottomRight: Radius.circular(80.0),
            ),
            color: Colors.redAccent,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      LoginAppPage(),
                      SizedBox(height: 0.0),
                      Divider(color: Colors.black),
                      buildCard("Login", Icon(Icons.file_upload), () {
                        flutterWebViewPlugin.launch(selectedUrl,
                            rect: Rect.fromLTWH(
                                0.0,
                                175.0,
                                MediaQuery.of(context).size.width - 43,
                                MediaQuery.of(context).size.height - 300.00),
                            withJavascript: true);
                        flutterWebViewPlugin.onStateChanged
                            .listen((viewState) async {
                          if (viewState.type == WebViewState.finishLoad) {
                            var givenJS =
                                rootBundle.loadString('assets/evalJS.js');
                            return givenJS.then((String js) {
                              flutterWebViewPlugin.evalJavascript(js);
                            });
                          }
                        });
                        flutterWebViewPlugin.onUrlChanged.listen((selectedUrl) {
                          flutterWebViewPlugin.onStateChanged
                              .listen((viewState) async {
                            if (viewState.type == WebViewState.finishLoad) {}
                          });
                        });
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
        //  circle check mark
        FractionalTranslation(
          translation: Offset(-0.0125, 0.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                flutterWebViewPlugin.close();
                flutterWebViewPlugin.dispose();
                Navigator.pop(context);
              },
              child: Material(
                elevation: 5.0,
                type: MaterialType.circle,
                color: Colors.greenAccent,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 37,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginAppPage extends StatelessWidget {
  //does nothing
  const LoginAppPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: Container(
        // decoration: BoxDecoration(
        // color: Colors.redAccent, borderRadius: BorderRadius.circular(80.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlutterLogo(size: 20.0),
                Text(
                  "UNM COLLEGE SOURCE",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Cabin Sketch',
                      color: Colors.white),
                ),
              ],
            ),
            // Container(),
          ],
        ),
      ),
    );
  }
}

buildCard(String title, Icon icon, Function callback) {
  return FlatButton(
    onPressed: (callback),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // if(title==''){},
      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
        SizedBox(width: 50.0),
        icon,
        SizedBox(width: 50.0),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ],
    ),
  );
}

class CustomDrawerClipper extends CustomClipper<Path> {
//makes circle
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height / 2 - 26);
    print(size.width);
    path.arcToPoint(
      Offset(size.width, size.height / 2 + 26),
      radius: Radius.circular(26.0),
      clockwise: false,
    );
    path.lineTo(size.width, size.height / 5 + 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// audit Requirments.
