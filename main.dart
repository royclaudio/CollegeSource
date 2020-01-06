import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Audit_Page.dart';
import 'login_page.dart';
import 'dart:async';

import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

String unmDisclaimer = """Sensitive and Protected Information Statement:
When using UNM online services, you agree to act in accordance with applicable laws, 
regulations, and also in accordance with The University of New Mexico policies, 
procedures and operational controls regarding UNM sensitive and protected data as identified in UNM Policy 2520, which states:
 Users are responsible for proper use and protection of University information and are prohibited from sharing information with unauthorized individuals.
: 2520 also states Access to USE THIS APP AS A GUIDE ONLY""";
//*** **/

List<Course> coursesList = [];
List<AuditPage> auditPageList = [];

void main() {
  runApp(MyApp());
}
//gets data web info to begin parsing the files 
Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(title: 'UNM CollegeSource'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();

    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Future<List<String>> getData() async {
    print('getData function start');
    int count = 0;

    List<String> myList = [];

    String data = await getFileData('assets/BSCS-CS.webarchive');

    dom.Document document = parser.parse(data);

    document.getElementsByTagName('tr').forEach((child) {
      count++;

      if (child.getElementsByTagName('td').isNotEmpty &&
          child.getElementsByTagName('td').first.text != '\s') {
        if (document
                .getElementsByTagName('tr')
                .first
                .text
                .contains('Prepared On') &&
            count == 1) {
          auditPageList.add(AuditPage(
            preparedOn: child.getElementsByTagName('td')[0].text,
            programCode: child.getElementsByTagName('td')[1].text,
            catalogYear: child.getElementsByTagName('td')[2].text,
          ));
         
        }
        if (child.getElementsByTagName('td').length >= 4) {
          coursesList.add(Course(
            term: child.getElementsByTagName('td')[0].text,
            takenCourse: child.getElementsByTagName('td')[1].text,
            credit: child.getElementsByTagName('td')[2].text,
            grade: child.getElementsByTagName('td')[3].text,
          ));
        }
      }
    });

    coursesList.removeAt(0);
    coursesList = coursesList.toSet().toList();

    print("data loaded");
    return myList;
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("UNM Disclaimer"),
          // backgroundColor: Color.fromRGBO(105, 105, 105, 1.0),
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                    text:
                        'This tool is intended to be used as a guide only. Contact your school or institution for an exact determination.\n'),
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 10.0),
                    text: unmDisclaimer),
                TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 10.0),
                    text: "\nthe app created by Roy Claudio")
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
          contentPadding:
              EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 5.0),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: key,
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.info),
                color: Colors.white,
                onPressed: showAbout)
          ],
          title: new Text(widget.title),
        ),
        drawer: AddLoginPage(),
        body: !loading
            ? RefreshIndicator(
                onRefresh: () async {
                  coursesList.clear();
                  getData();
                  setState(() {});
                },
                child: CourseListView(list: auditPageList),
              )
            : Center(
                child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.redAccent)),
              ),
      ),
    );
  }
}

class CourseListView extends StatefulWidget {
  const CourseListView({
    Key key,
    this.list,
  }) : super(key: key);

  final List<AuditPage> list;

  @override
  CourseListViewState createState() {
    return new CourseListViewState();
  }
}

class CourseListViewState extends State<CourseListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.isNotEmpty
            ? widget.list.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Stack(
                    children: <Widget>[
                      Dismissible(
                        key: Key(item.catalogYear),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {
                            widget.list.removeAt(widget.list.indexOf(item));
                          });
                        },
                        child: ClippedItem(item: item),
                      ),
                      CircleCompanyLogo(company: item.preparedOn)
                    ],
                  ),
                );
              }).toList()
            : []);
  }
}

class ClippedItem extends StatefulWidget {
  const ClippedItem({
    Key key,
    this.item,
  }) : super(key: key);

  final AuditPage item;

  @override
  ClippedItemState createState() {
    return ClippedItemState();
  }
}

class ClippedItemState extends State<ClippedItem>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: ClipPath(
        clipper: Clipper(),
        child: Card(
          color: Colors.red,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: InkWell(
            onTap: () {
              print(widget.item.catalogYear.trim());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(widget.item, coursesList),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 20.0, right: 10.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                            height: 50.0,
                            child: Text(
                              widget.item.programCode.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: Colors.white70,
                      ),
                      Text(
                        widget.item.catalogYear.trim(),
                        style: TextStyle(color: Colors.white70),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        widget.item.preparedOn.trim(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.adjust,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    var radius = 28.0;

    path.lineTo(0.0, size.height / 2 + radius);
    path.arcToPoint(
      Offset(0.0, size.height / 2 - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

buildListView() {}

class AuditPage {
  final String preparedOn; // Has taken course
  final String programCode;
  final String catalogYear;

  AuditPage({this.catalogYear, this.preparedOn, this.programCode});

  factory AuditPage.fromJson(Map<String, dynamic> json) {
    return AuditPage(
      preparedOn: json['preparedOn'],
      programCode: json['programCode'],
      catalogYear: json['catalogYear'],
    );
  }
}

class Course {
  final String takenCourse; // Has taken course
  final String term;
  final String credit;
  final String grade;
  final String courseID; // courseID
  final String description;
  // show list of courses needed to take for non-taken courses

  final String reqTitle;
  final String subreqTitle;
  final String fromCourses;
  final bool courseIP;

  Course(
      {this.takenCourse,
      this.courseID,
      this.description,
      this.credit,
      this.grade,
      this.term,
      this.reqTitle,
      this.subreqTitle,
      this.fromCourses,
      this.courseIP});

  factory Course.fromJson(Map<String, dynamic> json) {
    // List<String> fromCourseList = json['content']['rendered'].toString().split('"');

    return Course(
      takenCourse: json['takenCourse'],
      term: json['term'],
      credit: json['credit'],
      grade: json['grade'],
      courseID: json['courseID'],
      description: json['description'],
      reqTitle: json['reqTitle'],
      subreqTitle: json['subreqTitle'],
      fromCourses: json['fromCourses'],
      courseIP: json['courseIP'],
    );
  }
}

class CircleCompanyLogo extends StatefulWidget {
  final String company;

  const CircleCompanyLogo({
    this.company,
    Key key,
  }) : super(key: key);

  @override
  CircleCompanyLogoState createState() {
    return new CircleCompanyLogoState();
  }
}

class CircleCompanyLogoState extends State<CircleCompanyLogo>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return new CircleWithAnimation(widget: widget);
  }

  @override
  bool get wantKeepAlive => true;
}

class CircleWithAnimation extends StatefulWidget {
  const CircleWithAnimation({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CircleCompanyLogo widget;

  @override
  CircleWithAnimationState createState() {
    return new CircleWithAnimationState();
  }
}

class CircleWithAnimationState extends State<CircleWithAnimation>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
    animationController.forward();
  }

// circle + Icon
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FractionalTranslation(
        child: Material(
          type: MaterialType.circle,
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(105, 105, 105, 1.0),
                  border: Border.all(
                    width: 1.0,
                    color: Color.fromRGBO(105, 105, 105, 1.0),
                  )),
              height: 50.0,
              width: 50.0,
              child: FutureBuilder<Course>(
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: new AssetImage("assets/UNMLOGO.png"),
                    );
                  } else {
                    return new Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(105, 105, 105, 1.0),
                        ),
                      ),
                    );
                  }
                },
              )),
        ),
        translation: Offset(-0.5, 0.82),
      ),
    );
  }
}
