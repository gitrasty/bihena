import 'package:debitpad/login/login.dart';
import 'package:debitpad/shop/constants.dart';
import 'package:debitpad/shop/screens/home/home_screen.dart';
import 'package:debitpad/store/database/save_store.dart';
import 'package:debitpad/store/store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
 import 'package:url_launcher/url_launcher.dart';

import 'component/component.dart';
import 'form_qarz/home_page_qarz.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // title: 'Debitpad',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),

        theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.blue,
        fontFamily: "Gordita",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
        home: const home_screen() //MyHomePage(title: 'Debtpad'),
        );
  }
}

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  String _scanBarcode = 'Unknown';
  NumberFormat numberFormat = NumberFormat('###,###');

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
      if (_scanBarcode != 'Unknown') {
        for (int index = 0; index <= _categorylist.length; index++) {
          if (int.parse(_scanBarcode) == _categorylist[index].barcode) {
            var timestamp = _categorylist[index].date;

            _showformdaialog(_categorylist[index], timestamp);
          }
        }
      }
    });
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
              ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(
          'dwkan',
          style: TextStyle(color: blueasent),
        ),
        backgroundColor: template,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff7D8891),
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(300.0)),
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: template,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(350.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => store_data(),
                      )),
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Color(0xff5E6B75),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.local_grocery_store,
                                color: blueasent, size: 70),
                            Center(
                                child: Text(
                              'کۆگای بەرهەمەکان',
                              style: TextStyle(color: blueasent, fontSize: 25),
                            )),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'debitpad'),
                      )),
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Color(0xff5E6B75),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.list_alt, color: blueasent, size: 70),
                            Center(
                                child: Text('لیستی قەرزەکان',
                                    style: TextStyle(
                                        color: blueasent, fontSize: 25))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>HomeScreen(),
                      )),
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Color(0xff5E6B75),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.monetization_on,
                                color: blueasent, size: 70),
                            Center(
                                child: Text('کۆگاکانی فرۆشتن',
                                    style: TextStyle(
                                        color: blueasent, fontSize: 25))),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 70.0,
            width: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.qr_code_2_sharp,
                  size: 45,
                  color: template,
                ),
                onPressed: () => scanBarcodeNormal(),
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('چونەژورەوە'),
            
            leading: Icon(Icons.login),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => login(),)),
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
                        launchUrl(Uri.parse(
                            ('https://www.instagram.com/rasty__98/')));
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
                        launchUrl(Uri.parse(
                            ('https://www.facebook.com/profile.php?id=100009450179746')));
                      },
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        size: 60,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
