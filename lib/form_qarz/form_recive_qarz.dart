import 'package:debitpad/component/component.dart';

import 'package:debitpad/save.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as initl;

import 'home_page_qarz.dart';

class form_recive_qarz extends StatefulWidget {
  var id;
   form_recive_qarz({Key? key,this.id}) : super(key: key);

  @override
  State<form_recive_qarz> createState() => _form_recive_qarzState();
}

class _form_recive_qarzState extends State<form_recive_qarz> {
  var add_qarz = false;
  var _namecontroller = TextEditingController();
  var _qarzcontroller = TextEditingController();
  var _tebynycontroller = TextEditingController();
  var _phonenumber = TextEditingController();
  final GlobalKey<FormState> _formqarz = GlobalKey<FormState>();
  final GlobalKey<FormState> _formname = GlobalKey<FormState>();

  bool isFirst = true;
  var _value = 'دینار';
  DateTime selectedDate = DateTime.now();
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

  List<Catagory_user> _categorylist_user = <Catagory_user>[];
  var _categoryservice_user = Categoryservice_user();
  var _category_user = Catagory_user();
  getallcatagorys() async {
    _categorylist_user = <Catagory_user>[];
    var categorys_user = await _categoryservice_user.readbashakan();
    categorys_user.forEach((category) {
      setState(() {
        var categoryModel_user = Catagory_user();
        categoryModel_user.id = category['id'];
        categoryModel_user.name = category['name'];
        categoryModel_user.userid=category['userid'];
        categoryModel_user.date = category['date'];
        categoryModel_user.qarz = category['qarz'];
        categoryModel_user.tebyny = category['tebyny'];
        categoryModel_user.phonenumber = category['phonenumber'];
        categoryModel_user.jorypara = category['jorypara'];
        categoryModel_user.wargrtwnpedan = category['wargrtwnpedan'];

        _categorylist_user.add(categoryModel_user);
      });
    });
  }

  var firstdate_edite=0;
  var enddate_edite=0;
  var category;
  var _editenamecontroller_edite;
  var _editeqarzcontroller_edite;
  var _editetebynycontroller_edite;
  var _image_edite;
  var _categoryservice = Categoryservice();
  var _category = Catagory();


  editecategory() async {
    category = await _categoryservice.readcategoryId(widget.id);

    setState(() {
      _editenamecontroller_edite = category[0]['name'] ?? 'No name';
      //  editselectedDate = category[0]['date'] ?? 'No Date';
      _editeqarzcontroller_edite = category[0]['qarz'] ?? 'No qarz';
      _editetebynycontroller_edite = category[0]['tebyny'] ?? 'No tebyny';
      firstdate_edite = category[0]['date'] ?? 'No date';
      enddate_edite = category[0]['enddate'] ?? 'No date';
      _image_edite = category[0]['image'] ?? 'No image';
      _phonenumber_edite  = category[0]['phonenumber'] ?? 'No phonenumber';
      _wargr_edite  = category[0]['wargr'] ?? 'No wargr';
      _kafyl_edite  = category[0]['kafyl'] ?? 'No kafyl';
      _value_edite= category[0]['jorypara'] ?? 'No jorypara';


    });
    // _editeshowformdaialog();
  }
  var _value_edite ;
  var _phonenumber_edite ;
  var _wargr_edite  ;
  var _kafyl_edite  ;

  bool isChecked_wargr_edite = false;
  bool isChecked_kafyl_edite = false;
  bool isFirst_edite = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editecategory();
    getallcatagorys();
  }

  static const _locale = 'en';
  String _formatNumber(String s) =>
      initl.NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      initl.NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(
          "زیادکردن یام کەمکردنەوەی قەرز",
          style: TextStyle(color: blueasent),
        ),
        centerTitle: true,
        backgroundColor: template,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formname,
            child: Column(
              children: [

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

                        fillColor: Colors.white,
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
                SizedBox(
                  height: 20,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _qarzcontroller,
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
                    //   value =
                    //       initl.NumberFormat.currency(customPattern: '###,###')
                    //           .format(value1 / 100);
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
                SizedBox(
                  height: 20,
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

                      fillColor: Colors.white, // blueasent,
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
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Directionality(
                //   textDirection: TextDirection.rtl,
                //   child: TextField(
                //     controller: _tebynycontroller,
                //     autocorrect: false,
                //     maxLines: null,
                //     style: TextStyle(color: template),
                //     decoration: InputDecoration(
                //       hintMaxLines: 10,
                //       hintStyle: TextStyle(color: template),
                //       hintText: 'تێبینی',
                //       fillColor: blueasent,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(25.0),
                //         borderSide: BorderSide(),
                //       ),
                //       disabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(25.0),
                //           borderSide: BorderSide(color: template)),
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(25.0),
                //           borderSide: BorderSide(color: template)),
                //       focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(25.0),
                //           borderSide: BorderSide(
                //             color: template,
                //           )),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: add_qarz == false ? Colors.white : template,
                      child: Text(
                        'قەرزی زیاتر',
                        style: TextStyle(
                            color: add_qarz == false ? template : Colors.white,fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          add_qarz = true;
                        });
                      },
                    ),
                    MaterialButton(
                      color: add_qarz == true ? Colors.white : template,
                      child: Text(
                        'وەرگرتنەوەی قەرز',
                        style: TextStyle(
                            color: add_qarz == true ? template : Colors.white,fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          add_qarz = false;
                        });
                      },
                    ),
                  ],
                ),        Column(
                  children: [
                    Text(
                      'بەروار',
                      style: TextStyle(color: template),
                    ),
                    Container(

                      color: Colors.white, // blueasent,

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
                      if (_formname.currentState!.validate()) {
                      //  }
                      // if (_namecontroller.text.isNotEmpty &&
                      //     _qarzcontroller.text.isNotEmpty&&
                      // _phonenumber.text.isNotEmpty) {

                        _category_user.name = _namecontroller.text;
                        _category_user.qarz = _qarzcontroller.text;
                        _category_user.tebyny = _tebynycontroller.text;
                        _category_user.phonenumber = _phonenumber.text;

                        _category_user.jorypara = _value;
                        _category_user.wargrtwnpedan=add_qarz==false?'وەرگرتنەوەی قەرز'
                            :"قەرزی زیاتر";
                        _category_user.userid =  widget.id;

                        _category_user.date =
                            selectedDate.millisecondsSinceEpoch;

                      ///
                        //_category.id =widget.id;// category[0]['id'];

                        _category.name = _editenamecontroller_edite ;

                        print( double.parse(_editeqarzcontroller_edite.toString().replaceAll(',', '')));  print(double.parse(_qarzcontroller.text.toString().replaceAll(',', '')));
                        double calculate=add_qarz==false?
                        double.parse(_editeqarzcontroller_edite.toString().replaceAll(',', '')) - double.parse(_qarzcontroller.text.toString().replaceAll(',', ''))
                            :double.parse(_editeqarzcontroller_edite.toString().replaceAll(',', '')) + double.parse(_qarzcontroller.text.toString().replaceAll(',', ''));
                        _category.qarz = calculate.toString() ;
                        print('aera');
                        _category.tebyny = _editetebynycontroller_edite ;
                        _category.phonenumber = _phonenumber_edite ;
                        _category. wargr = _wargr_edite ;
                        _category.kafyl = _kafyl_edite ;
                        _category.jorypara =   _value_edite;

                        /// photo


                        _category.image = _image_edite;



                           _category.date = firstdate_edite;


                           _category.enddate = enddate_edite;


                         await _categoryservice
                            .updatebashakan(_category);



                      var result =
                      await _categoryservice_user.save(_category_user);
                      if (result > 0) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Debtpad'),
                        ));
                      } } else {
                        final snackBar = SnackBar(
                          content: const Text(
                              'زتکایە زانیارییە پێویستەکان پڕ بکەرەوە'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      _formname.currentState!.validate();
                     }
                  },
                  child: Text(
                    'هەلگرتن',
                    style: TextStyle(fontSize: 22, color: Color(0xff0003ff)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
