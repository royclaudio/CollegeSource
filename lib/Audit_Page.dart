
import 'package:flutter/material.dart';
import 'flutter_percent_indicator.dart';
// import 'package:card_settings/card_settings.dart';

import 'main.dart';

class Detail extends StatefulWidget {
  final job;
  final courseList;

  Detail(this.job, this.courseList);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  buildLogo() {
    return Material(
        type: MaterialType.card,
        elevation: 8.0,
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0)),
        child: Image.asset("assets/UNMLOGO.png"));
  }
//creates percentage bar to track progress 
// store and tracks GPA and completion 
  buildPercentage() {
    double gpa = 0;
    double gpapercentile = 0;
    double rawCredit = 0;
    double score = 0;
    double grade = 0;
    double completion = 0;
    double totalHours = 120;
    int multiplier = 0;
    List<String> letterGrade = [];
    List<String> credit = [];
    List<String> academicCareer = [];

    List<String> semesterRepeat = [];

    List<String> semesterFall16 = [];
    List<String> semesterSpring16 = [];
    List<String> semesterSpring17 = [];
    List<String> semesterFall17 = [];
    List<String> semesterSpring18 = [];

    List<String> semesterFall18 = [];

    List<String> semesterSpring19 = [];

    List<String> semesterFall19 = [];
    List<String> semesterSpring20 = [];

    List<PerSemester> dSemesterLists = [];

    int pricepersemester = 0;

    coursesList.forEach((child) {
      if (child.credit.length == 5) {
        // pricepersemester = (child.credit * 368) as int;
        academicCareer.add(
            child.term.trim() + child.credit + child.grade + child.takenCourse);
        credit.add(child.credit + child.takenCourse);
        letterGrade.add(child.grade + child.credit + child.takenCourse);
      }
    });
    academicCareer = academicCareer.toSet().toList();
    credit = credit.toSet().toList();
    letterGrade = letterGrade.toSet().toList();

    academicCareer.forEach((child) {
      print(child);
      if (child.contains("R:")) {
        
        semesterRepeat += [child];
      }
      if (child.contains("S:16")) {
        semesterSpring16 += [child];
      }
      if (child.contains("F:16")) {
        semesterFall16 += [child];
      }
      if (child.contains("S:17")) {
        semesterSpring17 += [child];
      }
      if (child.contains("F:17")) {
        semesterFall17 += [child];
      }
      if (child.contains("S:18")) {
        semesterSpring18 += [child];
      }
      if (child.contains("F:18")) {
        semesterFall18 += [child];
      }
      if (child.contains("S:19")) {
        semesterSpring19 += [child];
      }
      if (child.contains("F:19")) {
        semesterFall19 += [child];
      }
      if (child.contains("S:20")) {
        semesterSpring20 += [child];
      }
    });

    dSemesterLists.add(PerSemester("SPRING 2016", semesterSpring16));
    dSemesterLists.add(PerSemester("FALL 2016", semesterFall16));
    dSemesterLists.add(PerSemester("SPRING 2017", semesterSpring17));
    dSemesterLists.add(PerSemester("FALL 2017", semesterFall17));
    dSemesterLists.add(PerSemester("SPRING 2018", semesterSpring18));
    dSemesterLists.add(PerSemester("FALL 2018", semesterFall18));
    dSemesterLists.add(PerSemester("SPRING 2019", semesterSpring19));
    dSemesterLists.add(PerSemester("FALL 2019", semesterFall19));
    dSemesterLists.add(PerSemester("SPRING 2020", semesterSpring20));
    dSemesterLists.add(PerSemester("Repeated Course", semesterRepeat));

    print(dSemesterLists.length);

    dSemesterLists.forEach((child) {
      print(child.semester);
    });

    credit.forEach((child) {
      if (double.parse(child[1]) != 1) {
        completion += double.parse(child[1]);
      }
    });

    letterGrade.forEach((child) {
      if (child.contains('A')) {
        grade = 4;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
      if (child.contains('A+')) {
        grade = 4.33;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
      if (child.contains('A-')) {
        grade = 3.67;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }

      if (child.contains('B')) {
        grade = 3;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
      if (child.contains('B-')) {
        grade = 2.67;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
      if (child.contains('B+')) {
        grade = 3.33;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }

      if (child.contains('C')) {
        grade = 2;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
      if (child.contains('C+')) {
        grade = 2.33;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
      if (child.contains('C-')) {
        grade = 1.67;
        gpa += grade;
        rawCredit += int.parse(child[5]);
        if ((multiplier = int.parse(child[5])) == 0) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 1) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 3) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 4) {
          score += grade * multiplier;
        }
        if ((multiplier = int.parse(child[5])) == 5) {
          score += grade * multiplier;
        }
      }
    });

    gpapercentile = (score / rawCredit) / 4.33;

    gpa = score / rawCredit;

    double tocompletion = completion / totalHours;

    num number = num.parse(tocompletion.toStringAsFixed(2));

    num gpanum = num.parse(gpa.toStringAsFixed(2));

    return Container(
        color: Colors.red,
        child: ListView(
          children: <Widget>[
            CircularPercentIndicator(
              radius: 150.0,
              lineWidth: 15.0,
              percent: tocompletion,
              center: Text("$number" + '%'),
              footer: Text("% TO COMPLETION"),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey,
              maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
              linearGradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.green],
              ),
            ),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: gpapercentile,
              center: Text("$gpanum"),
              footer: Text("GPA"),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey,
              maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
              linearGradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.green],
              ),
            ),
            // for (var child in dSemesterLists)
            new Container(
              width: 300,
              height: 300,
              child: buildBlocks(dSemesterLists, "child.semester"),
            ),
          ],
        ));
  }

  Widget showAboutClasses(List<String> list, String term) {
    double gpa = 0;
    double cost = 0;
    double avgCost = 359.86;

    for (var child in list) {
      if (child.contains('1.0')) {
        cost += 1 * avgCost;
      }
      if (child.contains('2.0')) {
        cost += 2 * avgCost;
      }
      if (child.contains('3.0')) {
        cost += 3 * avgCost;
      }
      if (child.contains('4.0')) {
        cost += 4 * avgCost;
      }
      if (child.contains('5.0')) {
        cost += 5 * avgCost;
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(term),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            // title: Text(term),
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,

              // backgroundColor: Color.fromRGBO(105, 105, 105, 1.0),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (var child in list)
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                              text: child.trim()),
                        ]),
                      ),
                      
                    Text(
                      "Gpa: "+WhatsMyGpa(list).toString(),
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    Text(
                      "Cost: "+num.parse(cost.toStringAsFixed(2)).toString() + '\$',
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                      
                    // text: 'price'),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // contentPadding:
            // EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 5.0),
          ),
        );
      },
    );
  }

  Widget buildBlocks(List<PerSemester> list, String semester) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index].semester;
        return Card(
          child: ListTile(
              title: Text(item),
              subtitle: Text(list[index].classes.toString()),
              onTap: () {
                showAboutClasses(list[index].classes, item);
              }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.red,
          child: Stack(
            children: <Widget>[
              Material(
                elevation: 51.0,
                color: Color.fromRGBO(105, 105, 105, 1.0),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0)),
                child: Container(
                  height: 150.0,
                ),
              ),
              Material(
                elevation: 0.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Material(
                    elevation: 0.0,
                    type: MaterialType.canvas,
                    color: Color.fromRGBO(105, 105, 105, 1.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Container(
                height: 160.0,
                child: FractionalTranslation(
                  translation: Offset(0.0, 0.25),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/UNMLOGO.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 160.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text("",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white)),
                        ),
                      ),
                      Expanded(child: buildPercentage()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.crop_landscape,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "${widget.job.programCode.trim()}",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "${widget.job.preparedOn.trim()}",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class PerSemester {
  final String semester;
  final List<String> classes;
  // final int pricepersemester;

  PerSemester(this.semester, this.classes);
}

double WhatsMyGpa(List<String> grades) {
  double gpa = 0;
  double rawCredit = 0;
  double score = 0;
  double grade = 0;
  int multiplier = 0;
  grades.forEach((child) {
    // if(!child.contains('IP')) return 0;
    if (child.contains('A')&& !child.contains('IP')) {
      grade = 4;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
    if (child.contains('A+')&& !child.contains('IP')) {
      grade = 4.33;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
    if (child.contains('A-')&& !child.contains('IP')) {
      grade = 3.67;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }

    if (child.contains('B')&& !child.contains('IP')) {
      grade = 3;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
    if (child.contains('B-')&& !child.contains('IP')) {
      grade = 2.67;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
    if (child.contains('B+')&& !child.contains('IP')) {
      grade = 3.33;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }

    if (child.contains('C')&& !child.contains('IP')) {
      grade = 2;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
    if (child.contains('C+')&& !child.contains('IP')) {
      grade = 2.33;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
    if (child.contains('C-')&& !child.contains('IP')) {
      grade = 1.67;
      gpa += grade;
      rawCredit += int.parse(child[5]);
      if ((multiplier = int.parse(child[5])) == 0) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 1) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 3) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 4) {
        score += grade * multiplier;
      }
      if ((multiplier = int.parse(child[5])) == 5) {
        score += grade * multiplier;
      }
    }
  });
  gpa = score / rawCredit;
  num gpanum = num.parse(gpa.toStringAsFixed(2));

  return gpanum;
}
