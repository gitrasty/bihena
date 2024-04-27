import 'package:debitpad/store/database/save_store.dart';
import 'package:debitpad/store/store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart'as initl;

import '../component/component.dart';

class add_data_store extends StatefulWidget {
  final  barcode;
  const add_data_store({Key? key,   this.barcode}) : super(key: key);

  @override
  State<add_data_store> createState() => _add_data_storeState();
}

class _add_data_storeState extends State<add_data_store> {
  var _namecontroller = TextEditingController();
  var _nrx = TextEditingController();
  var _nrxy_froshtn=TextEditingController();
var  _companya=TextEditingController();
 var _phonenumber_company=TextEditingController();
  bool isFirst = true;
  bool isFirst_froshtn= true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<Catagory_store> _categorylist = <Catagory_store>[];
  var _categoryservice_store = Categoryservice_store();
  var _category_store = Catagory_store();
  getallcatagorys() async {
    _categorylist = <Catagory_store>[];
    var categorys = await _categoryservice_store.readbashakan();
    categorys.forEach((category) {
      setState(() {
        var categoryModel = Catagory_store();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryModel.barcode=category['barcode'];
        categoryModel.date = category['date'];
        categoryModel.namecompany = category['namecompany'];
        categoryModel.nrx = category['nrx'];
        categoryModel.phonenumber_company = category['phonenumber_company'];
        categoryModel.jorypara = category['jorypara'];
categoryModel.nrxy_froshtn=category['nrxy_froshtn'];
        _categorylist.add(categoryModel);
      });
    });
  }
  DateTime selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930),
    lastDate: DateTime.now().add(Duration(days: 10000)));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  var _value = 'دینار';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getallcatagorys();}

  static const _locale = 'en';
  String _formatNumber(String s) =>
      initl.NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      initl.NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'کۆگا',
          style: TextStyle(color: blueasent),
        ),
        backgroundColor: template,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(

            children: [
              SizedBox(
                height: 50,
              ),
              Center(child: Icon(FontAwesomeIcons.barcode,size: 100,),),
              Center(child: Text('Barcode : '+widget.barcode.toString(),style: TextStyle(fontSize: 22),),),
              SizedBox(
                height: 10,
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
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(color: template),
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(
                          color: template,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: _nrx,
                  validator: (value) {
                    if (value!.isEmpty || value == '.00') {
                      return 'نرخەکەی بە دروستی دیاری بکە';
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
                    _nrx.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                  // onChanged: (value) {
                  //   String newValue =
                  //   value.replaceAll(',', '').replaceAll('.', '');
                  //   if (value.isEmpty || newValue == '00') {
                  //     _nrx.clear();
                  //     isFirst = true;
                  //     return;
                  //   }
                  //   double value1 = double.parse(newValue);
                  //   if (!isFirst) value1 = value1 * 100;
                  //   value =
                  //       initl.NumberFormat.currency(customPattern: '###,###')
                  //           .format(value1 / 100);
                  //   _nrx.value = TextEditingValue(
                  //     text:value=='.00'?'': value,
                  //     selection:
                  //     TextSelection.collapsed(offset: value.length),
                  //   );
                  // },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: template),
                    hintText: 'نرخ',
                    filled: true,

                    fillColor: Colors.white, // blueasent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(color: template),
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(
                          color: template,
                        )),
                  ),
                ),
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
                  controller: _nrxy_froshtn,
                  validator: (value) {
                    if (value!.isEmpty || value == '.00') {
                      return 'نرخەکەی بە دروستی دیاری بکە';
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
                    _nrxy_froshtn.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                  // onChanged: (value) {
                  //   String newValue =
                  //   value.replaceAll(',', '').replaceAll('.', '');
                  //   if (value.isEmpty || newValue == '00') {
                  //     _nrxy_froshtn.clear();
                  //     isFirst_froshtn = true;
                  //     return;
                  //   }
                  //   double value1 = double.parse(newValue);
                  //   if (!isFirst_froshtn) value1 = value1 * 100;
                  //   value =
                  //       initl.NumberFormat.currency(customPattern: '###,###')
                  //           .format(value1 / 100);
                  //   _nrxy_froshtn.value = TextEditingValue(
                  //     text:value=='.00'?'': value,
                  //     selection:
                  //     TextSelection.collapsed(offset: value.length),
                  //   );
                  // },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: template),
                    hintText: 'نرخی فرۆشتن',
                    filled: true,

                    fillColor: Colors.white, // blueasent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: template),
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(
                          color: template,
                        )),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: _companya,
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
                    hintText: 'کۆمپانیا',
                    hintStyle: TextStyle(
                      color: template,
                    ),
                    //    labelText: "Name",
                    filled: true,

                    fillColor: Colors.white, // blueasent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(color: template),
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(
                          color: template,
                        )),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: _phonenumber_company,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ژمارە موبایلی قەزار بنوسە";
                    }
                  },
                  autocorrect: false,
                  style: TextStyle(color: template),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,

                    hintStyle: TextStyle(color: template),
                    hintText: 'ژمارە موبایلی کۆمپانیا ',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(),
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: template)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
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
                    'بەرواری بەسەرچوون',
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
                          color:  Color(0xff0003ff),
                          style: BorderStyle.solid,
                        ),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height:30,
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
                      side: BorderSide(color:  Color(0xff0003ff), width: 2),
                    ),
                    onPressed: () async {
                      try {
                        if (!formkey.currentState!.validate()) {
                          return ;
                        }
                        if (_namecontroller.text.isNotEmpty )
                        {
                          _category_store.barcode=int.parse(widget.barcode);
                          _category_store.name = _namecontroller.text;
                          _category_store.nrx = _nrx.text;
                          _category_store.nrxy_froshtn = _nrxy_froshtn.text;

                          _category_store.namecompany = _companya.text;
                          _category_store.phonenumber_company = _phonenumber_company.text;
                          _category_store.jorypara = _value;


                          _category_store.date =
                              selectedDate.millisecondsSinceEpoch;


                          var result =
                          await _categoryservice_store.save(_category_store);


                          if (result > 0) {
                            //  print(result);
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => store_data(),
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
                        formkey.currentState!.validate();
                        _namecontroller.text = "";
                        // _nrx.text = "";
                        // _nrxy_froshtn.text = "";

                      }
                    },
                    child: Text(
                      'هەلگرتن',
                      style:
                      TextStyle(fontSize: 22, color:  Color(0xff0003ff)),
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
