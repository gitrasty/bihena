import 'package:debitpad/component/component.dart';
import 'package:debitpad/form_qarz/display_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../save.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  var _searchcontroller = TextEditingController();
  var _categoryservice = Categoryservice();
  var _category = Catagory();
  List<Catagory> _categorylist = <Catagory>[];
  getallcatagorys() async {
    _categorylist = <Catagory>[];
    var categorys = await _categoryservice.searchbashakan(keyword);
    categorys.forEach((category) {
      setState(() {
        var categoryModel = Catagory();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.date = category['date'];
        categoryModel.enddate = category['enddate'];
        categoryModel.qarz = category['qarz'];

        _categorylist.add(categoryModel);
      });
    });
  }

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
                    builder: (context) => MyApp(),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getallcatagorys();
  }

  String keyword = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: template,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black,
                      offset: Offset(0, 0.5),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: blueasent,
                            ),
                          ],
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 0.5),
                              blurRadius: 0.1,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _searchcontroller,
                        onChanged: (value) {
                          setState(() {
                            keyword = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'گەڕان',
                          contentPadding: EdgeInsets.all(3.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 1,
              //decoration: BoxDecoration(
              //  color: Colors.blue,
              //borderRadius: BorderRadius.circular(15),
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 3,
              //     color: Colors.black,
              //     offset: Offset(0, 0.5),
              //   )
              // ],
              //),
              child: FutureBuilder(
                future: _categoryservice.searchbashakan(keyword),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data[index]['name'];
                      var timestamp = snapshot.data[index]['date'];
                      var endtimestamp = snapshot.data[index]['enddate'];

                      var end_time = DateFormat(' d/ MM/ yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(endtimestamp!,
                              isUtc: false)
                          //        .add(Duration(days: 30))
                          );
                      DateFormat tempDate_edn = DateFormat(' d/ MM/ yyyy');
                      var datenow = DateTime.now();

                      return Column(
                        children: [
                          MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => display_form(
                                  name: snapshot.data[index]['name'],
                                  qarz: snapshot.data[index]['qarz'],
                                  date: snapshot.data[index]['date'],
                                  enddate: snapshot.data[index]['enddate'],
                                  coment: snapshot.data[index]['tebyny'],
                                ),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: datenow.isBefore(
                                          tempDate_edn.parse(end_time))
                                      //   DateFormat(' d/ MM/ yyyy').format(DateTime.now()) >= end_time
                                      ? Colors.white
                                      : Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black87,
                                        offset: Offset(0, 0.75),
                                        blurRadius: 5)
                                  ],
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blueAccent.shade700,
                                    //Colors.indigoAccent.shade200,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    radius: 30,
                                  ),
                                  // leading: IconButton(
                                  //     onPressed: () {
                                  //       editecategory(_categorylist[index].id);
                                  //     },
                                  //     icon: Icon(Icons.edit)),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text('ناو'),
                                          Text(snapshot.data[index]['name']),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('قەرز'),
                                          Text(snapshot.data[index]['qarz']),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _delete(snapshot.data[index]['id']);
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text('دەستپێک'),
                                          Text(
                                              '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp!, isUtc: false))
                                              //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)

                                              }'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('کۆتا'),

                                          Text(
                                              '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(endtimestamp, isUtc: false))}')
                                          // Text(
                                          //     '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).add(Duration(days: 30)))}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              // ListView.builder(
              //   itemCount: _categorylist.length,
              //   itemBuilder: (context, index) {
              //     var timestamp = _categorylist[index].date;
              //     var endtimestamp = _categorylist[index].enddate;
              //
              //     var end_time = DateFormat(' d/ MM/ yyyy').format(
              //         DateTime.fromMillisecondsSinceEpoch(endtimestamp!,
              //             isUtc: false)
              //         //        .add(Duration(days: 30))
              //         );
              //     DateFormat tempDate_edn = DateFormat(' d/ MM/ yyyy');
              //     var datenow = DateTime.now();
              //
              //     return keword != null
              //         ? Column(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(6.0),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     color: datenow
              //                             .isBefore(tempDate_edn.parse(end_time))
              //                         //   DateFormat(' d/ MM/ yyyy').format(DateTime.now()) >= end_time
              //                         ? Colors.grey.shade100
              //                         : Colors.redAccent,
              //                     borderRadius: BorderRadius.circular(20),
              //                     boxShadow: [
              //                       BoxShadow(
              //                           color: Colors.black87,
              //                           offset: Offset(0, 0.75),
              //                           blurRadius: 5)
              //                     ],
              //                   ),
              //                   child: ListTile(
              //                     leading: CircleAvatar(
              //                       backgroundColor: Colors.blueAccent.shade700,
              //                       //Colors.indigoAccent.shade200,
              //                       child: Icon(
              //                         Icons.person,
              //                         size: 50,
              //                         color: Colors.white,
              //                       ),
              //                       radius: 30,
              //                     ),
              //                     // leading: IconButton(
              //                     //     onPressed: () {
              //                     //       editecategory(_categorylist[index].id);
              //                     //     },
              //                     //     icon: Icon(Icons.edit)),
              //                     title: Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Column(
              //                           children: [
              //                             Text('ناو'),
              //                             Text(_categorylist[index].name),
              //                           ],
              //                         ),
              //                         Column(
              //                           children: [
              //                             Text('قەرز'),
              //                             Text(_categorylist[index].qarz),
              //                           ],
              //                         ),
              //                         // IconButton(
              //                         //   onPressed: () {
              //                         //     _delete(_categorylist[index].id);
              //                         //   },
              //                         //   icon: Icon(Icons.delete),
              //                         //   color: Colors.black,
              //                         // ),
              //                       ],
              //                     ),
              //                     subtitle: Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Column(
              //                           children: [
              //                             Text('دەستپێک'),
              //                             Text(
              //                                 '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp!, isUtc: false))
              //                                 //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)
              //
              //                                 }'),
              //                           ],
              //                         ),
              //                         Column(
              //                           children: [
              //                             Text('کۆتا'),
              //
              //                             Text(
              //                                 '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(endtimestamp, isUtc: false))}')
              //                             // Text(
              //                             //     '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).add(Duration(days: 30)))}'),
              //                           ],
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           )
              //         : Text('no data');
              //   },
              // ),
            )
          ],
        ),
      ),
    ));
  }
}
