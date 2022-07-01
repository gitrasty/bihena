import 'package:debitpad/component/component.dart';
import 'package:debitpad/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

import 'add_data_store.dart';
import 'database/save_store.dart';

class store_data extends StatefulWidget {
  const store_data({Key? key}) : super(key: key);

  @override
  State<store_data> createState() => _store_dataState();
}

class _store_dataState extends State<store_data> {
  String _scanBarcode = 'Unknown';
  List<Catagory_store> _categorylist = <Catagory_store>[];
  var _categoryservice = Categoryservice_store();
  var _category = Catagory_store();
  getallcatagorys() async {
    _categorylist = <Catagory_store>[];
    var categorys = await _categoryservice.readbashakan();
    categorys.forEach((category) {
      setState(() {
        var categoryModel = Catagory_store();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.barcode = category['barcode'];
        categoryModel.date = category['date'];
        categoryModel.namecompany = category['namecompany'];
        categoryModel.nrx = category['nrx'];
        categoryModel.phonenumber_company = category['phonenumbercompany'];
        categoryModel.jorypara = category['jorypara'];
        categoryModel.nrxy_froshtn = category['nrxyfroshtn'];
        _categorylist.add(categoryModel);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getallcatagorys();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
     // for (int index = 0; index < _categorylist.length; index++)
        if (_scanBarcode != 'Unknown'
          //   &&
          // int.parse(_scanBarcode) != _categorylist[index].barcode
        ) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => add_data_store(barcode: _scanBarcode),
          ));
        } else {
          final snackBar = SnackBar(
            content: const Text('ئەم باردکۆدە پێشتر داخل کراوە'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
    });
  }

  NumberFormat numberFormat = NumberFormat('###,###');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => home_screen(),
              ));
            },
            icon: Icon(Icons.arrow_back_rounded)),
        title: Text(
          'کۆگا',
          style: TextStyle(color: blueasent),
        ),
        backgroundColor: template,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: DataTable(columnSpacing: 50, columns: [
                      DataColumn(
                        label: Text(
                          'نرخی فرۆشتن',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'نرخ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ناو',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          '#',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ], rows: [
                      for (int index = 0; index < _categorylist.length; index++)
                        DataRow(
                          cells: [
                            DataCell(Text(
                                '${(_categorylist[index].jorypara == 'دۆلار') ? '\$ ' : ''}'
                                '${_categorylist[index].nrxy_froshtn.length <= 10 ?
                                numberFormat.format(double.parse(_categorylist[index].nrxy_froshtn.replaceAll(',', ''))) :
                                numberFormat.format(double.parse(_categorylist[index].nrxy_froshtn.replaceAll(',', '')))}')),
                            DataCell(Text(
                                '${(_categorylist[index].jorypara == 'دۆلار') ? '\$ ' : ''}'
                                '${_categorylist[index].nrx.length <= 10 ?
                                numberFormat.format(double.parse(_categorylist[index].nrx.replaceAll(',', '')))
                                    : numberFormat.format(double.parse(_categorylist[index].nrx.replaceAll(',', '')))}')),
                            DataCell(Text(_categorylist[index].name.length <= 8
                                ? _categorylist[index].name
                                : _categorylist[index].name.substring(0, 8) +
                                    '....')),
                            DataCell(
                                Text(_categorylist[index].barcode.toString())),
                          ],
                          onLongPress: () {
                            var timestamp = _categorylist[index].date;

                            _showformdaialog(_categorylist[index], timestamp);
                          },
                        )
                    ]),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: _categorylist.length,
                    //   itemBuilder: (context, index) {
                    //     var timestamp = _categorylist[index].date;
                    //
                    //     DateFormat tempDate_edn = DateFormat(' d/ MM/ yyyy');
                    //     var datenow = DateTime.now();
                    //
                    //     var start_time = DateFormat('yyyy-mm-dd hh:mm:ss')
                    //         .format(DateTime.fromMillisecondsSinceEpoch(
                    //                 timestamp!,
                    //                 isUtc: false)
                    //             //        .add(Duration(days: 30))
                    //             );
                    //     var timee = DateFormat(' d/ MM/ yyyy').format(
                    //         DateTime.fromMillisecondsSinceEpoch(timestamp!,
                    //             isUtc: false)
                    //         //        .add(Duration(days: 30))
                    //         );
                    //
                    //     return                         Column(
                    //       children: [
                    //         Container(
                    //           decoration: BoxDecoration(
                    //             color: datenow
                    //                     .isBefore(tempDate_edn.parse(timee))
                    //                 //   DateFormat(' d/ MM/ yyyy').format(DateTime.now()) >= end_time
                    //                 ? Colors.white
                    //                 : Colors.redAccent,
                    //           ),
                    //           child: ListTile(
                    //             onTap: () {
                    //               // Navigator.of(context).push(MaterialPageRoute(
                    //               //   builder: (context) => display_form(
                    //               //     id: _categorylist[index].id,
                    //               //     name: _categorylist[index].name,
                    //               //     qarz: _categorylist[index].qarz,
                    //               //     date: _categorylist[index].date,
                    //               //     enddate: _categorylist[index].enddate,
                    //               //     coment: _categorylist[index].tebyny,
                    //               //     image: File(
                    //               //         _categorylist[index].image.toString()),
                    //               //     jorypara: _categorylist[index].jorypara,
                    //               //     kafyl:  _categorylist[index].kafyl,
                    //               //     phonenumber:  _categorylist[index].phonenumber,
                    //               //     wagr:  _categorylist[index].wargr,
                    //               //
                    //               //   ),
                    //               // ));
                    //             },
                    //             onLongPress: () {
                    //               //    _delete(_categorylist[index].id);
                    //             },
                    //             title: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 Column(
                    //                   children: [
                    //                     Text('قەرز'),
                    //                     Text(
                    //                         '${(_categorylist[index].jorypara == 'دۆلار') ? '\$ ' : ''}${_categorylist[index].nrx.length <= 10 ? numberFormat.format(double.parse(_categorylist[index].nrx.replaceAll(',', ''))) : numberFormat.format(double.parse(_categorylist[index].nrx.replaceAll(',', '')))}'
                    //
                    //                         //     .substring(0, 10) +
                    //                         // '....')
                    //                         ),
                    //                   ],
                    //                 ),
                    //                 Column(
                    //                   children: [
                    //                     Text('ناو'),
                    //                     Text(_categorylist[index].name.length <=
                    //                             10
                    //                         ? _categorylist[index].name
                    //                         : _categorylist[index]
                    //                                 .name
                    //                                 .substring(0, 10) +
                    //                             '....'),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             subtitle: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   children: [
                    //                     Text('دەستپێک'),
                    //                     Text(
                    //                         '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp!, isUtc: false))
                    //                         //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)
                    //
                    //                         }'),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         Divider(),
                    //       ],
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: template,
        child: Icon(
          Icons.qr_code_2_sharp,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () => scanBarcodeNormal(),
      ),
    );
  }

  _showformdaialog(_categorylist, timestamp) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              actions: [
                MaterialButton(
                  color: template,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'لابردن',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    _delete(_categorylist.id);
                  },
                  child: Text('سڕینەوە'),
                ),
              ],
              title: Text(''),
              content: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(_categorylist.barcode.toString()),
                    ),
                    Text(': بارکۆد '),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(_categorylist.name),
                    ),
                    Text(': ناو '),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                          '${(_categorylist.jorypara == 'دۆلار') ? '\$ ' : ''}${_categorylist.nrx.length <= 10 ? numberFormat.format(double.parse(_categorylist.nrx.replaceAll(',', ''))) : numberFormat.format(double.parse(_categorylist.nrx.replaceAll(',', '')))}'

                          //     .substring(0, 10) +
                          // '....')
                          ),
                    ),
                    Text(': نرخ '),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                          '${(_categorylist.jorypara == 'دۆلار') ? '\$ ' : ''}'
                          '${_categorylist.nrx.length <= 10 ? numberFormat.format(double.parse(_categorylist.nrxy_froshtn.replaceAll(',', ''))) : numberFormat.format(double.parse(_categorylist.nrx.replaceAll(',', '')))}'

                          //     .substring(0, 10) +
                          // '....')
                          ),
                    ),
                    Text(': نرخی فرۆشتن '),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Text(_categorylist.name)),
                    Text(': کۆمپانیا '),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child:
                            Text(_categorylist.phonenumber_company.toString())),
                    Text(':ژمارەی کۆمپانیا '),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                            '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp!, isUtc: false))
                            //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)

                            }'),
                      ),
                      Text(': بەرواری بەسەرچوون '),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
              ]));
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
                    builder: (context) => store_data(),
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
}
