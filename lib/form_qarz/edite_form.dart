import 'dart:io';
 import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart' as inital;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../component/component.dart';
import '../main.dart';
import '../save.dart';

class edite_form_qarz extends StatefulWidget {
  var id;
  var name;
  var date;
  var enddate;
  var qarz;
  var coment;
  var image;
  edite_form_qarz(
      {Key? key,
      this.id,
      this.name,
      this.date,
      this.enddate,
      this.qarz,
      this.coment,
      this.image});

  @override
  _edite_form_qarzState createState() => _edite_form_qarzState();
}

class _edite_form_qarzState extends State<edite_form_qarz> {
  var _editenamecontroller = TextEditingController();

  var _editeqarzcontroller = TextEditingController();
  var _editetebynycontroller = TextEditingController();

  var _categoryservice = Categoryservice();
  var _category = Catagory();
  var selectedDate = DateTime.now();

  DateTime editselectedDate = DateTime.now();

  var endtedDate = DateTime.now();


  var _image='';

  var firstdate=0;
  var enddate=0;
  var category;
  editecategory() async {
    category = await _categoryservice.readcategoryId(widget.id);

    setState(() {
      _editenamecontroller.text = category[0]['name'] ?? 'No name';
      //  editselectedDate = category[0]['date'] ?? 'No Date';
      _editeqarzcontroller.text = category[0]['qarz'] ?? 'No qarz';
      _editetebynycontroller.text = category[0]['tebyny'] ?? 'No tebyny';
      firstdate = category[0]['date'] ?? 'No date';
      enddate = category[0]['enddate'] ?? 'No date';
      _image = category[0]['image'] ?? 'No image';
      _phonenumber.text = category[0]['phonenumber'] ?? 'No phonenumber';
      _wargr.text = category[0]['wargr'] ?? 'No wargr';
      _kafyl.text = category[0]['kafyl'] ?? 'No kafyl';
      _value= category[0]['jorypara'] ?? 'No jorypara';


    });
    // _editeshowformdaialog();
  }

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
    });
  }

  final ImagePicker _picker = ImagePicker();

  getimage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }

  var _newimage;
  imgFromCamera(ImageSource imageSource) async {
    XFile? imagefile = await _picker.pickImage(source: imageSource);

    if (imagefile == null) return;
    File tmpfile = File(imagefile.path);
    final appdir = await getApplicationDocumentsDirectory();
    final filename = path.basename(imagefile.path);
    tmpfile = await tmpfile.copy('${appdir.path}/$filename}');
    setState(() {
      _newimage = tmpfile;
      print('>>>>>>>>>>1111 $_newimage');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editecategory();
  }
  var _value = 'دینار';
  var _phonenumber = TextEditingController();
  var _wargr = TextEditingController();
   var _kafyl = TextEditingController();

  bool isChecked_wargr = false;
  bool isChecked_kafyl = false;
  bool isFirst = true;
  final GlobalKey<FormState> formname = GlobalKey<FormState>();
  final GlobalKey<FormState> formqarz = GlobalKey<FormState>();
  final GlobalKey<FormState> formphonenumber = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: template,
              iconTheme: IconThemeData(color:blueasent),
              title: Text(
                'دەسکاری کردن',
                style: TextStyle(
                    color:blueasent, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        // getimage();
                        imgFromCamera(ImageSource.camera);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: template,
                        child: _image != '' && _newimage == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.file(
                                  File(_image),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : _image == '' && _newimage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image.file(
                                      _newimage,
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
                    TextField(
                      controller: _editenamecontroller,
                      autocorrect: false,
                      style: TextStyle(color: template),
                      decoration: InputDecoration(
                        hintText: 'ناو',
                        //    labelText: "Name",
                        hintStyle: TextStyle(color: template),

                        filled: true,
                        fillColor:  Colors.white,                        border: OutlineInputBorder(
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
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextField(
                    //   controller: _editeqarzcontroller,
                    //   autocorrect: false,
                    //   keyboardType: TextInputType.number,
                    //   style: TextStyle(color: template),
                    //
                    //   decoration: InputDecoration(
                    //     hintStyle:  TextStyle(color: template),
                    //
                    //     hintText: 'بڕی پارەی قەرز',
                    //     //    labelText: "Name",
                    //     fillColor: blueasent,
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(25.0),
                    //       borderSide: BorderSide(),
                    //     ),
                    //     disabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25.0),
                    //         borderSide: BorderSide(color: template)),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25.0),
                    //         borderSide: BorderSide(color: template)),
                    //     focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25.0),
                    //         borderSide: BorderSide(
                    //           color: template,
                    //         )),),
                    // ),
                    SizedBox(
                      height: 20,
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
                                fillColor:  Colors.white,                                border: OutlineInputBorder(
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
                                fillColor:  Colors.white,                                border: OutlineInputBorder(
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
                        controller: _editeqarzcontroller,
                        validator: (value) {
                          if (value!.isEmpty || value == '.00') {
                            return 'بڕی قەرزەکە بە دروستی دیاری بکە';
                          }
                        },
                        autocorrect: false,
                        style: TextStyle(color: template),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          String newValue =
                          value.replaceAll(',', '').replaceAll('.', '');
                          if (value.isEmpty || newValue == '00') {
                            _editeqarzcontroller.clear();
                            isFirst = true;
                            return;
                          }
                          double value1 = double.parse(newValue);
                          if (!isFirst) value1 = value1 * 100;
                          value = inital.NumberFormat.currency(
                              customPattern: '###,###')
                              .format(value1 / 100);
                          _editeqarzcontroller.value = TextEditingValue(
                            text: value,
                            selection:
                            TextSelection.collapsed(offset: value.length),
                          );
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: template),
                          hintText: 'بڕی پارەی قەرز',
                          filled: true,
                          fillColor:  Colors.white,                          border: OutlineInputBorder(
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
                          fillColor:  Colors.white,                          border: OutlineInputBorder(
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
                    TextField(
                      controller: _editetebynycontroller,
                      autocorrect: false,
                      maxLines: null,
                      style: TextStyle(color: template),
                      decoration: InputDecoration(
                        hintMaxLines: 10,
                        hintStyle: TextStyle(color: template),

                        hintText: 'تێبینی',
                        //    labelText: "Name",
                        filled: true,
                        fillColor:  Colors.white,

                        border: OutlineInputBorder(
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
                            )),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${inital.DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(firstdate, isUtc: false))}',
                            ),
                            Text('بەرواری دەستپێکردن'),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          height: 50,                          color: Colors.white,

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${inital.DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(enddate, isUtc: false))}',
                            ),
                            Text('بەرواری کۆتایی هاتن'),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          height: 50,
                          color: Colors.white,
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
                                side: BorderSide(
                                    color:Color(0xff0003ff), width: 2),
                              ),
                              onPressed: () async {
                                _category.id = category[0]['id'];
                                _category.name = _editenamecontroller.text;
                                _category.qarz = _editeqarzcontroller.text;
                                _category.tebyny = _editetebynycontroller.text;
                                _category.phonenumber = _phonenumber.text ;
                                _category. wargr = _wargr.text ;
                                _category.kafyl = _kafyl.text ;
                                _category.jorypara =   _value;
                                /// photo

                                String imagepath;
                                // =
                                //     _image != null ? _image.path : '';
                                if (_image != '' && _newimage == null) {
                                  _category.image = _image;
                                } else if (_newimage != null && _image == '') {
                                  _category.image = _newimage.path;
                                }
                                // _category.image = imagepath;

                                ///
                                //_qarzcontroller.text;

                                if (selectedDate.day == DateTime.now().day) {
                                  _category.date = widget.date;
                                } else {
                                  _category.date =
                                      selectedDate.millisecondsSinceEpoch;
                                }

                                if (endtedDate.day == DateTime.now().day) {
                                  _category.enddate = widget.enddate;
                                } else {
                                  _category.enddate =
                                      endtedDate.millisecondsSinceEpoch;
                                }

                                var result = await _categoryservice
                                    .updatebashakan(_category);
                                if (result > 0) {
                                  print(result);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyApp(),
                                  ));

                                  // Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                'هەلگرتن',
                                style: TextStyle(
                                    fontSize: 22, color: Color(0xff0003ff)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
