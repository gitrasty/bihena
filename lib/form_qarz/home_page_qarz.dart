import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:async';
import 'package:debitpad/form_qarz/display_form.dart';
import 'package:debitpad/form_qarz/formy_qarz.dart';
import 'package:debitpad/save.dart';
import 'package:debitpad/search/search.dart';
import 'package:debitpad/store/store_data.dart';
 import 'package:flutter/services.dart';

import '../component/component.dart';
import '../main.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bool search = false;
  var _namecontroller = TextEditingController();

  var _qarzcontroller = TextEditingController();
  var _editenamecontroller = TextEditingController();

  var _categoryservice = Categoryservice();
  var _category = Catagory();

  DateTime selectedDate = DateTime.now();

  DateTime editselectedDate = DateTime.now();

  DateTime endtedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endtedDate,
        firstDate: DateTime(1930),
        lastDate: DateTime.now().add(Duration(days: 10000)));
    if (picked != null && picked != endtedDate)
      setState(() {
        endtedDate = picked;
      });
  }

  Future<void> _editeselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  List<Catagory> _categorylist = <Catagory>[];
  getallcatagorys() async {
    _categorylist = <Catagory>[];
    var categorys = await _categoryservice.readbashakan();
    categorys.forEach((category) {
      setState(() {
        var categoryModel = Catagory();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.date = category['date'];
        categoryModel.enddate = category['enddate'];
        categoryModel.qarz = category['qarz'];
        categoryModel.tebyny = category['tebyny'];
        categoryModel.image = category['image'];
        categoryModel.phonenumber = category['phonenumber'];
        categoryModel.wargr = category['wargr'];
        categoryModel.kafyl = category['kafyl'];
        categoryModel.jorypara = category['jorypara'];

        _categorylist.add(categoryModel);
      });
      if (category['jorypara'] == 'دۆلار') {
        totaldolar = (totaldolar +
            double.parse(category['qarz'].toString().replaceAll(',', '')));
      } else {
        total = (total +
            double.parse(category['qarz'].toString().replaceAll(',', '')));
      }
    });
  }

  double totaldolar = 0;

  double total = 0;

  _showformdaialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: [
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('لابردن'),
            ),
            MaterialButton(
              onPressed: () async {
                _category.name = _namecontroller.text;
                _category.qarz = _qarzcontroller.text;
                //_qarzcontroller.text;
                _category.date = selectedDate.millisecondsSinceEpoch;
                _category.enddate = endtedDate.millisecondsSinceEpoch;

                var result = await _categoryservice.save(_category);
                if (result > 0) {
                  print(result);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(title: ''),
                  ));

                  // Navigator.of(context).pop();
                }
              },
              color: blueasent,
              child: Text('هەلگرتن'),
            )
          ],
          title: Text('فۆرمی داخڵکردنی قەرز'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurpleAccent.shade700,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                TextField(
                  controller: _namecontroller,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'ناو',
                    //    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: _qarzcontroller,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(),

                    hintText: 'بڕی پارەی قەرز',
                    //    labelText: "Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text('بەرواری دەستپێکردن'),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          (selectedDate.year == null)
                              ? 'کاتەکەت دیاری بکە'
                              : "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: blueasent,
                            style: BorderStyle.solid,
                          ),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text('بەرواری کۆتایی هاتن'),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () => _endDate(context),
                        child: Text(
                          (endtedDate.year == null)
                              ? 'کاتەکەت دیاری بکە'
                              : "${endtedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: blueasent,
                            style: BorderStyle.solid,
                          ),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var category;

  _delete(categoryId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: [
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('لابردن'),
            ),
            MaterialButton(
              onPressed: () async {
                var result = await _categoryservice.deletebashakan(categoryId);
                if (result > 0) {
                  print(result);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(title: 'title'),
                  ));
                  //  Navigator.of(context).pop();
                }
              },
              color: Colors.blue,
              child: Text('سڕینەوە'),
            )
          ],
          title: Text('دڵنیایت لە سڕینەوەی ئەم ناوە'),
          content: SingleChildScrollView(),
        );
      },
    );
  }

  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getallcatagorys();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.day, from.month, from.year);

    // from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.day, to.month, to.year);

    // to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  var two_pi = 3.14 * 2;
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<DateTime> getDays({required DateTime start, required DateTime end}) {
    final days = end.difference(start).inDays;

    return [for (int i = 0; i < days; i++) start.add(Duration(days: i))];
  }

  NumberFormat numberFormat = NumberFormat('###,###');
  @override
  Widget build(BuildContext context) {
    double totalWidth = ((MediaQuery.of(context).size.width / 2));

    final birthday = DateTime(2020, 10, 12);
    final date2 = DateTime.now();
    // final difference = daysBetween(birthday, date2);

    var size = 200.0;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor:template,

          //Colors.indigoAccent.shade200,
          title: Text(
            'سیستمەی قەرز',
            style: TextStyle(color: blueasent, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: blueasent),
          elevation: 1,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => search(),
                        ));
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: blueasent,
                    )),
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: blueasent,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ),
            ],
          ),

          leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => home_screen(),
                  ));
                });
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                size: 30,
              )),
        ),
        body:

        // RefreshIndicator(
        //   key: refreshkey,
        //   onRefresh: () async {
        //     refreshkey.currentState?.show(atTop: false);
        //     await Future.delayed(Duration(seconds: 2));
        //     setState(() {
        //       getallcatagorys();
        //     });
        //   },
          //child:
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 120,
                      decoration: BoxDecoration(
                        color: template,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              offset: Offset(0, 0.75),
                              blurRadius: 5)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "کۆی گشتی قەرزەکان",
                            style: TextStyle(fontSize: 22, color: blueasent),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' دینار ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                '${numberFormat.format(total)}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 120,
                      decoration: BoxDecoration(
                        color: template,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              offset: Offset(0, 0.75),
                              blurRadius: 5)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "کۆی گشتی قەرزەکان",
                            style: TextStyle(fontSize: 22, color: blueasent),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' \$ ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                '${totaldolar}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _categorylist.length,
                  itemBuilder: (context, index) {
                    var timestamp = _categorylist[index].date;
                    var endtimestamp = _categorylist[index].enddate;

                    var end_time = DateFormat(' d/ MM/ yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(endtimestamp!,
                            isUtc: false)
                      //        .add(Duration(days: 30))
                    );
                    DateFormat tempDate_edn = DateFormat(' d/ MM/ yyyy');
                    var datenow = DateTime.now();

                    final difference = daysBetween(birthday, date2);

                    var start_time = DateFormat('yyyy-mm-dd hh:mm:ss').format(
                        DateTime.fromMillisecondsSinceEpoch(timestamp!,
                            isUtc: false)
                      //        .add(Duration(days: 30))
                    );
                    var end_time2 = DateFormat('yyyy-mm-dd hh:mm:ss').format(
                        DateTime.fromMillisecondsSinceEpoch(endtimestamp!,
                            isUtc: false)
                      //        .add(Duration(days: 30))
                    );
                    List<DateTime> days = getDays(
                      start: DateTime.now(),
                      end: DateTime.parse(end_time2),
                    );

                    // for(int i=0;i< days.length;i++) {
                    //   print('days ${DateFormat('dd').format(
                    //       days[i]
                    //
                    //   )}');
                    // }
                    return Column(
                      children: [
                        // TweenAnimationBuilder(
                        //   tween: Tween(
                        //       begin:
                        //           //double.parse(DateTime.now().day.toString())
                        //
                        //           // double.parse(DateTime.now().day.toString())
                        //
                        //           0.0,
                        //       end: 1.0),
                        //   duration: Duration(seconds: 4),
                        //   builder: (context, double value, child) {
                        //     int precntage = (value * 100).ceil();
                        //     return Container(
                        //       width: size,
                        //       height: size,
                        //       child: Stack(
                        //         children: [
                        //           ShaderMask(
                        //             shaderCallback: (rect) {
                        //               return SweepGradient(
                        //                       colors: [Colors.blue, Colors.grey],
                        //                       startAngle: 0.0,
                        //                       endAngle: two_pi,
                        //                       stops: [value, value],
                        //                       center: Alignment.center)
                        //                   .createShader(rect);
                        //             },
                        //             child: Container(
                        //               width: size,
                        //               height: size,
                        //               decoration: BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Colors.white),
                        //             ),
                        //           ),
                        //           Center(
                        //             child: Container(
                        //               width: size - 40,
                        //               height: size - 40,
                        //               decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   shape: BoxShape.circle),
                        //               child: Center(
                        //                 child: Text(
                        //                   '${precntage}',
                        //                   style: TextStyle(fontSize: 40),
                        //                 ),
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),
                        // Text('${end_time
                        //
                        //     //difference / 1000
                        //     //        int.parse(birthday.day) - int.parse(date2.day)
                        //     }'),
                        ///
                        // LinearPercentIndicator(
                        //   width: MediaQuery.of(context).size.width,
                        //   animation: true,
                        //   animationDuration: 1000,
                        //   lineHeight: 100.0,
                        //   percent: difference / 1000,

                        //      center:
                        // ListTile(
                        //   leading: CircleAvatar(
                        //     backgroundColor: Colors.indigoAccent.shade200,
                        //     child: Icon(
                        //       Icons.person,
                        //       size: 50,
                        //       color: Colors.white,
                        //     ),
                        //     radius: 30,
                        //   ),
                        //   // leading: IconButton(
                        //   //     onPressed: () {
                        //   //       editecategory(_categorylist[index].id);
                        //   //     },
                        //   //     icon: Icon(Icons.edit)),
                        //   title: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(_categorylist[index].name),
                        //       IconButton(
                        //         onPressed: () {
                        //           _delete(_categorylist[index].id);
                        //         },
                        //         icon: Icon(Icons.delete),
                        //         color: Colors.black,
                        //       ),
                        //     ],
                        //   ),
                        //   subtitle: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Column(
                        //         children: [
                        //           Text('دەستپێک'),
                        //           Text(
                        //               '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp!, isUtc: false))
                        //               //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)
                        //
                        //               }'),
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text('کۆتا'),
                        //
                        //           Text(
                        //               '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(endtimestamp, isUtc: false))}')
                        //           // Text(
                        //           //     '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).add(Duration(days: 30)))}'),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),

                        //Text("${difference / 10}%"),
                        //linearStrokeCap: LinearStrokeCap.butt,
                        //   progressColor: Colors.greenAccent.shade100,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: datenow
                                .isBefore(tempDate_edn.parse(end_time))
                            //   DateFormat(' d/ MM/ yyyy').format(DateTime.now()) >= end_time
                                ? Colors.white
                                : Colors.redAccent,

                            //
                            // borderRadius: BorderRadius.circular(20),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.black87,
                            //       offset: Offset(0, 0.75),
                            //       blurRadius: 5)
                            // ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => display_form(
                                  id: _categorylist[index].id,
                                  name: _categorylist[index].name,
                                  qarz: _categorylist[index].qarz,
                                  date: _categorylist[index].date,
                                  enddate: _categorylist[index].enddate,
                                  coment: _categorylist[index].tebyny,
                                  image: File(
                                      _categorylist[index].image.toString()),
                                  jorypara: _categorylist[index].jorypara,
                                  kafyl: _categorylist[index].kafyl,
                                  phonenumber: _categorylist[index].phonenumber,
                                  wagr: _categorylist[index].wargr,
                                ),
                              ));
                            },
                            onLongPress: () {
                              _delete(_categorylist[index].id);
                            },
                            trailing: CircleAvatar(
                              // backgroundColor: blueasent,

                              //Colors.indigoAccent.shade200,
                              child: Center(
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: template,
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topRight,
                                      //   end: Alignment.bottomLeft,
                                      //   colors: [
                                      //     //  Color(0xff0003ff),
                                      //     Colors.deepPurpleAccent.shade700,
                                      //     Colors.deepPurple.shade400,
                                      //     Colors.white
                                      //   ],
                                      // ),
                                    ),
                                    child: Center(
                                      child: _categorylist[index].image != '' &&
                                          _categorylist[index].image != null
                                          ? ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        child: Image.file(
                                          File(_categorylist[index]
                                              .image
                                              .toString()),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                          : Text(
                                        _categorylist[index].name[0],
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      // Icon(
                                      //         Icons.person,
                                      //         size: 50,
                                      //         color: Colors.white,
                                      //       ),
                                    )),
                              ),
                              radius: 30,
                            ),
                            // leading: IconButton(
                            //     onPressed: () {
                            //       editecategory(_categorylist[index].id);
                            //     },
                            //     icon: Icon(Icons.edit)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text('قەرز'),
                                    Text(
                                        '${(_categorylist[index].jorypara == 'دۆلار') ? '\$ ' : ''}${_categorylist[index].qarz.length <= 10 ? numberFormat.format(double.parse(_categorylist[index].qarz.replaceAll(',', ''))) : numberFormat.format(double.parse(_categorylist[index].qarz.replaceAll(',', '')))}'

                                      //     .substring(0, 10) +
                                      // '....')
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('ناو'),
                                    Text(_categorylist[index].name.length <= 10
                                        ? _categorylist[index].name
                                        : _categorylist[index]
                                        .name
                                        .substring(0, 10) +
                                        '....'),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('کۆتا'),

                                    Text(
                                        '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(endtimestamp, isUtc: false))}')
                                    // Text(
                                    //     '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).add(Duration(days: 30)))}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('دەستپێک'),
                                    Text(
                                        '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp!, isUtc: false))
                                        //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)

                                        }'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => formy_qarz(),
            )); // _showformdaialog();
          },
          tooltip: 'Increment',
          backgroundColor: template,
          child: const Icon(Icons.person_add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        endDrawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.store),
                title: Text('کۆگا'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => store_data(),
                  ));
                },
              ),
              Text('''Design and Development
               by Rasty__98'''),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              offset: Offset(3.0, 3.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                        ],
                        // gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [
                        //       Colors.grey[200],
                        //       Colors.grey[300],
                        //       Colors.grey[400],
                        //       Colors.grey[500],
                        //     ],
                        //     stops: [
                        //       0.1,
                        //       0.3,
                        //       0.8,
                        //       1
                        //     ]),
                      ),
                      child: IconButton(
                        onPressed: () {
                          launch('https://www.instagram.com/rasty__98/');
                        },
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          size: 40,
                          color: Colors.pinkAccent.shade700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: blueasent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              offset: Offset(3.0, 3.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                        ],
                        // gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [
                        //       Colors.grey[200],
                        //       Colors.grey[300],
                        //       Colors.grey[400],
                        //       Colors.grey[500],
                        //     ],
                        //     stops: [
                        //       0.1,
                        //       0.3,
                        //       0.8,
                        //       1
                        //     ]),
                      ),
                      child: IconButton(
                        onPressed: () {
                          launch(
                              'https://www.facebook.com/profile.php?id=100009450179746');
                        },
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
