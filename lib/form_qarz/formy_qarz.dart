import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:debitpad/form_qarz/home_page_qarz.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as inital;
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../component/component.dart';
import '../main.dart';
import '../save.dart';

class formy_qarz extends StatefulWidget {
  const formy_qarz({Key? key}) : super(key: key);

  @override
  _formy_qarzState createState() => _formy_qarzState();
}

class _formy_qarzState extends State<formy_qarz> {
  var _namecontroller = TextEditingController();

  var _qarzcontroller = TextEditingController();
  var _tebynycontroller = TextEditingController();
  var _phonenumber = TextEditingController();
  var _wargr = TextEditingController();

  var _kafyl = TextEditingController();
  var _categoryservice = Categoryservice();
  var _category = Catagory();
  DateTime selectedDate = DateTime.now();

  DateTime editselectedDate = DateTime.now();

  DateTime endtedDate = DateTime.now();
  bool isChecked_wargr = false;
  bool isChecked_kafyl = false;
  bool isFirst = true;
  final GlobalKey<FormState> formname = GlobalKey<FormState>();
  final GlobalKey<FormState> formqarz = GlobalKey<FormState>();
  final GlobalKey<FormState> formphonenumber = GlobalKey<FormState>();

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
        categoryModel.phonenumber = category['phonenumber'];
        categoryModel.wargr = category['wargr'];
        categoryModel.kafyl = category['kafyl'];
        categoryModel.jorypara = category['jorypara'];

        _categorylist.add(categoryModel);
      });
    });
  }

  final ImagePicker _picker = ImagePicker();

  getimage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }

  var _image;

  imgFromCamera(ImageSource imageSource) async {
    // XFile? image =
    //     await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    //
    // setState(() {
    //   // _image = image;
    //
    //   _image = File(image!.path);
    //
    //   print('>>>>>> $_image');
    // });
    //
    XFile? imagefile = await _picker.pickImage(source: imageSource);

    if (imagefile == null) return;
    File tmpfile = File(imagefile.path);
    final appdir = await getApplicationDocumentsDirectory();
    final filename = path.basename(imagefile.path);
    tmpfile = await tmpfile.copy('${appdir.path}/$filename}');
    setState(() {
      _image = tmpfile;
      print('>>>>>>>>>> $_image');
    });
  }

  var _value = 'دینار';
  static const _locale = 'en';
  String _formatNumber(String s) =>
      inital.NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      inital.NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: template,
              iconTheme: IconThemeData(color: blueasent),
              title: Text(
                'فۆڕمی قەرزار',
                style: TextStyle(color: blueasent, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formname,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          // getimage();
                          imgFromCamera(ImageSource.camera);
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: template, //blueasent,
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.file(
                                    _image,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 90,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _namecontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "بە دروستی ناوەکە بنوسە";
                            }
                          },
                          autocorrect: false,
                          style: TextStyle(
                            color: template,
                          ),
                          decoration: InputDecoration(
                            hintText: 'ناو',
                            hintStyle: TextStyle(
                              color: template,
                            ),
                            //    labelText: "Name",
                            filled: true,
                            fillColor: Colors.white, // blueasent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: template),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: template,
                                )),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('کەفیل'),
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.all(template),
                                value: isChecked_kafyl,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked_kafyl = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('وەرگر'),
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.all(template),
                                value: isChecked_wargr,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked_wargr = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isChecked_wargr,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'ئەگەر کەسەکە خۆی پارەکەی وەنەگرت ناوی وەرگرەکە ئەنوسرێت',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: template),
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: _wargr,
                                autocorrect: false,
                                style: TextStyle(color: template),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: template),
                                  hintText: 'وەرگر',
                                  filled: true,
                                  fillColor: Colors.white,                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: template)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: template)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: template,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isChecked_kafyl,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'ناوی کەفیلەکە',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: template),
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: _kafyl,
                                autocorrect: false,
                                style: TextStyle(color: template),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: template),
                                  hintText: 'کەفیل',
                                  filled: true,
                                  fillColor: Colors.white,                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: template)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(color: template)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: template,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _qarzcontroller,
                          validator: (value) {
                            if (value!.isEmpty || value == '00') {
                              //if (value!.isEmpty || value == '.00') {
                              return 'بڕی قەرزەکە بە دروستی دیاری بکە';
                            }
                          },
                          autocorrect: false,
                          style: TextStyle(color: template),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
    onChanged: (string) {
    string = '${_formatNumber(string.replaceAll(',', ''))}';
    _qarzcontroller.value = TextEditingValue(
    text: string,
    selection: TextSelection.collapsed(offset: string.length),
    );
    },
                          // onChanged: (value) {
                          //   String newValue =
                          //       value.replaceAll(',', '').replaceAll('.', '');
                          //   if (value.isEmpty || newValue == '00') {
                          //     _qarzcontroller.clear();
                          //     isFirst = true;
                          //     return;
                          //   }
                          //   double value1 = double.parse(newValue);
                          //   if (!isFirst) value1 = value1 * 100;
                          //   value = inital.NumberFormat.currency(
                          //           customPattern: '###,###')
                          //       .format(value1 / 100);
                          //   _qarzcontroller.value = TextEditingValue(
                          //     text:value=='.00'?'': value,
                          //     selection:
                          //         TextSelection.collapsed(offset: value.length),
                          //   );
                          // },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: template),
                            hintText: 'بڕی پارەی قەرز',
                            filled: true,
                            fillColor: Colors.white,                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: template),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: template,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text("دۆلار"),
                              value: 'دۆلار',
                              groupValue: _value,
                              activeColor: template,
                              onChanged: (value) {
                                setState(() {
                                  _value = 'دۆلار';
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text("دینار"),
                              value: 'دینار',
                              groupValue: _value,
                              activeColor: template,
                              onChanged: (value) {
                                setState(() {
                                  _value = 'دینار';
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _phonenumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "ژمارە موبایلی قەزار بنوسە";
                            }
                          },
                          autocorrect: false,
                          style: TextStyle(color: template),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: template),
                            hintText: 'ژمارە موبایل',
                            filled: true,
                            fillColor: Colors.white,                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: template,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: _tebynycontroller,
                          autocorrect: false,
                          maxLines: 10,

                          style: TextStyle(color: template),
                          decoration: InputDecoration(
                            hintMaxLines: 10,

                            hintStyle: TextStyle(color: template),
                            hintText: 'تێبینی',
                            filled: true,
                            fillColor: Colors.white,                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: template)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: template,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            'بەروار',
                            style: TextStyle(color: template),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10.0, left: 10),
                            height: 50,
                            color: Colors.white,
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
                                  color: Color(0xff0003ff),
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
                            height: 50,                            color: Colors.white,

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
                                  color: Color(0xff0003ff),
                                  style: BorderStyle.solid,
                                ),
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  side: BorderSide(
                                      color: Colors.redAccent, width: 2),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'لابردن',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.redAccent),
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  side: BorderSide(color: Color(0xff0003ff), width: 2),
                                ),
                                onPressed: () async {
                                  try {
                                     if (!formname.currentState!.validate()) {
                                       return ;
                                     }
                                    if (_namecontroller.text.isNotEmpty &&
                                        _qarzcontroller.text.isNotEmpty &&
                                        _phonenumber.text.isNotEmpty) {

                                      _category.name = _namecontroller.text;
                                      _category.qarz = _qarzcontroller.text;
                                      _category.tebyny = _tebynycontroller.text;
                                      _category.phonenumber = _phonenumber.text;
                                      _category.kafyl = _kafyl.text;
                                      _category.wargr = _wargr.text;
                                      _category.jorypara = _value;

                                      /// photo
                                      String imagepath =
                                          _image != null ? _image.path : '';
                                      _category.image = imagepath;

                                      ///
                                      //_qarzcontroller.text;
                                      _category.date =
                                          selectedDate.millisecondsSinceEpoch;
                                      _category.enddate =
                                          endtedDate.millisecondsSinceEpoch;

                                      var result =
                                          await _categoryservice.save(_category);
                                      if (result > 0) {
                                      //  print(result);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => MyHomePage(title: ''),
                                        ));

                                        // Navigator.of(context).pop();

                                      }
                                    } else {
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            'تکایە زانیارییە پێویستەکان پڕ بکەرەوە'),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } catch (e) {
                                    formname.currentState!.validate();
                                    formqarz.currentState!.validate();
                                    formphonenumber.currentState!.validate();
                                    _namecontroller.text = "";
                                    _qarzcontroller.text = "";
                                    _phonenumber.text = "";
                                  }
                                },
                                child: Text(
                                  'هەلگرتن',
                                  style:
                                      TextStyle(fontSize: 22, color: Color(0xff0003ff)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
