import 'package:debitpad/form_qarz/edite_form.dart';
import 'package:debitpad/form_qarz/form_recive_qarz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as initl;
import 'package:intl/intl.dart';

import '../component/component.dart';
import '../save.dart';

class display_form extends StatefulWidget {
  var id;
  var name;
  var date;
  var enddate;
  var qarz;
  var coment;
  var image;
  var wagr;
  var kafyl;
  var phonenumber;
  var jorypara;
  display_form(
      {Key? key,
      this.id,
      this.name,
      this.date,
      this.enddate,
      this.qarz,
      this.coment,
      this.image,
      this.jorypara,
      this.kafyl,
      this.phonenumber,
      this.wagr});

  @override
  _display_formState createState() => _display_formState();
}

class _display_formState extends State<display_form> {
  List<Catagory_user> _categorylist_user = <Catagory_user>[];
  var _categoryservice_user = Categoryservice_user();
  var _category_user = Catagory_user();
  int listy_parakan=0;
  getallcatagorys_user() async {
    _categorylist_user = <Catagory_user>[];
    var categorys_user = await _categoryservice_user.readbashakan();
    categorys_user.forEach((category) {
      setState(() {
        var categoryModel_user = Catagory_user();
        categoryModel_user.id = category['id'];
        categoryModel_user.name = category['name'];
        categoryModel_user.userid = category['userid'];
        categoryModel_user.date = category['date'];
        categoryModel_user.qarz = category['qarz'];
        categoryModel_user.tebyny = category['tebyny'];
        categoryModel_user.phonenumber = category['phonenumber'];
        categoryModel_user.jorypara = category['jorypara'];
        categoryModel_user.wargrtwnpedan = category['wargrtwnpedan'];

        _categorylist_user.add(categoryModel_user);
        if (widget.id == category['userid']) {
          listy_parakan = _categorylist_user.length;
          print('>>>>' + listy_parakan.toString());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallcatagorys_user();
  }

  NumberFormat numberFormat = NumberFormat('###,###');
  @override
  Widget build(BuildContext context) {
    var timestamp = widget.date;
    var endtimestamp = widget.enddate;

    var end_time = initl.DateFormat(' d/ MM/ yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(endtimestamp!, isUtc: false)
            //        .add(Duration(days: 30))
            );
    initl.DateFormat tempDate_edn = initl.DateFormat(' d/ MM/ yyyy');
    var datenow = DateTime.now();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: template,
        title: Text(
          'فۆرمی زانیاری قەزدار',
          style: TextStyle(color: blueasent, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: blueasent),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => edite_form_qarz(
                  id: widget.id,
                  date: widget.date,
                  enddate: widget.enddate,
                ),
              ));
            },
            icon: Icon(
              Icons.edit,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: template,
                        child:
                            widget.image.path != '' && widget.image.path != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.file(
                                      widget.image,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 90,
                                    color: Colors.white,
                                  ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${widget.name} : ناو ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.phonenumber} : ژمارە موبایل ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.wagr} : وەرگر ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.kafyl} : کەفیل ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          ' ${widget.jorypara == 'دۆلار' ? '\$' : ''}  بڕی قەرز : ${widget.qarz.replaceAll('.00', '')}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                  Container(
                    child: Text(
                      '''${widget.coment}''',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('بەرواری هێنانەوەی قەرز',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),

                          Text(
                            '${initl.DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(endtimestamp, isUtc: false))}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                          // Text(
                          //     '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).add(Duration(days: 30)))}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('بەرواری پێدانی قەرز',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              '${initl.DateFormat(' d/ MM/ yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(timestamp!,
                                    isUtc: false),
                              )
                              //DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)

                              }',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: listy_parakan * 110,
                width: double.infinity,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _categorylist_user.length,
                  itemBuilder: (context, index) {
                    return (widget.id != _categorylist_user[index].userid)
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // _categorylist_user[index].wargrtwnpedan=='وەرگرتنەوەی قەرز'
                                  //      ? Colors.greenAccent.shade100
                                  //     : Colors.blueAccent.shade100,

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 6), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {},
                                  onLongPress: () {
                                    _delete(_categorylist_user[index].id);
                                  },
                                  leading: CircleAvatar(
                                    // backgroundColor: blueasent,

                                    //Colors.indigoAccent.shade200,
                                    child: Center(
                                      child: Container(
                                          height: 70,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _categorylist_user[index]
                                                        .wargrtwnpedan ==
                                                    'وەرگرتنەوەی قەرز'
                                                ? Colors.greenAccent.shade200
                                                : Colors.blueAccent.shade200,
                                          ),
                                          child: Center(
                                            child: Text(
                                              _categorylist_user[index]
                                                          .wargrtwnpedan ==
                                                      'وەرگرتنەوەی قەرز'
                                                  ? 'وەرگرتن'
                                                  : 'پێدان',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: template),
                                            ),
                                          )),
                                    ),
                                    radius: 30,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('ناو'),
                                          Text(_categorylist_user[index]
                                                      .name
                                                      .length <=
                                                  10
                                              ? _categorylist_user[index].name
                                              : _categorylist_user[index]
                                                      .name
                                                      .substring(0, 10) +
                                                  '....'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'بڕی',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            ' ${widget.jorypara == 'دۆلار' ? '\$' : ''}'
                                            '${_categorylist_user[index].qarz.length <= 10 ? numberFormat.format(double.parse(_categorylist_user[index].qarz.replaceAll(',', ''))) : numberFormat.format(double.parse(_categorylist_user[index].qarz.replaceAll(',', '')))} ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('ژ.م'),
                                          Text( _categorylist_user[index]
                                              .phonenumber),
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          Text('لە بەرواری'),
                                          Text(
                                              '${DateFormat(' d/ MM/ yyyy').format(DateTime.fromMillisecondsSinceEpoch(_categorylist_user[index].date!, isUtc: false))}'),
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
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.zero,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => form_recive_qarz(
                id: widget.id,
              ),
            ));
          },
          backgroundColor: Color(0xff1e272e),
          child: const Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
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
              child: Text(
                'لابردن',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                var result =
                    await _categoryservice_user.deletebashakan(categoryId);
                if (result > 0) {
                  print(result);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    display_form(
                      id: widget.id,
                      name: widget.name,
                      qarz: widget.qarz,
                      date: widget.date,
                      enddate:widget.enddate,
                      coment:widget.coment,
                      image: widget.image.toString() ,
                      jorypara: widget.jorypara,
                      kafyl:  widget.kafyl,
                      phonenumber:  widget.phonenumber,
                      wagr:  widget.wagr,
                    ),));

                 }
              },
              color: blueasent,
              child: Text(
                'سڕینەوە',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          title: Text('دڵنیایت لە سڕینەوەی ئەم ناوە'),
          content: SingleChildScrollView(),
        );
      },
    );
  }
}
