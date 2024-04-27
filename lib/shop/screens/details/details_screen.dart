import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../component/component.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import '../../models/Product.dart';

class DetailsScreen extends StatefulWidget {
  var data;
  DetailsScreen({Key? key, this.data}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var api = 'http://192.168.0.107';
  bool _visible = false;

  Future _getdata() async {
    var url = Uri.parse(
        'http://192.168.0.107/bihena/company_author/product_company.php');
    var response = await http.post(url);

    return jsonDecode(response.body);

    // var url = Uri.parse(
    //     'http://192.168.0.107/bihena/company_author/product_company.php');
    // // Showing LinearProgressIndicator.
    //
    //
    // // Getting username and password from Controller
    // var data = {
    //   'id': '1',
    // };
    //
    // //Starting Web API Call.
    // var response = await http.post(url,
    //     headers: {"Content-Type": "application/json; charset=UTF-8"},
    //     body: json.encode(data));
    //   print(jsonDecode(response.body));
    //  return jsonDecode(response.body);

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    //
    //   // //Server response into variable
    //   // var msg = jsonDecode(response.body);
    //   //  //Check Login Status
    //   // if (msg['loginStatus'] == true) {
    //   //   setState(() {
    //   //     //hide progress indicator
    //   //     _visible = false;
    //   //   });
    //   //   print(response.body);
    //   //
    //   //   return jsonDecode(response.body);
    //   //
    //   // } else {
    //   //   setState(() {
    //   //     //hide progress indicator
    //   //     _visible = false;
    //   //
    //   //     //Show Error Message Dialog
    //   //    });
    //   // }
    // }
    // else {
    //   setState(() {
    //     //hide progress indicator
    //     _visible = false;
    //
    //     //Show Error Message Dialog
    //    });
    // }
  }

  int length=2 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _getdata().then((value) {
      setState(() {
      length=value.where((e) => e['id_company'] == widget.data['id']).length;

      });

    });
  }

  Product? product;

  final ScrollController _controller = ScrollController();
  final double _height = 100.0;



  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          widget.data['username'].toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        // controller: _controller,
        children: [
          // Visibility(
          //   visible: _visible,
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 10.0),
          //     child: LinearProgressIndicator(),
          //   ),
          // ),
          Container(
            height: 200,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        "$api/bihena/image/profile/${widget.data['image']}",
                        height: MediaQuery.of(context).size.height / 4, //* 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                // Positioned(
                //   top: 130,
                //   child: Column(
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Container(
                //             width: 270,
                //             height: 80,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                     color: Colors.black45,
                //                     offset: Offset(0, 0.1),
                //                     blurRadius: 2)
                //               ],
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   Column(
                //                     children: [
                //                       Text(
                //                         'ناوی کۆمپانیا',
                //                         textAlign: TextAlign.end,
                //                         style: Theme.of(context).textTheme.titleLarge,
                //                       ),
                //                       Text(
                //                         'جبس ، بسکیت ، قاوە',
                //                         textAlign: TextAlign.end,
                //                         style: Theme.of(context).textTheme.bodyMedium,
                //                       ),
                //                       Divider(
                //                         color: Colors.black,
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           Container(
                //             width: 120,
                //             height: 120,
                //             padding: EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.only(
                //                     topLeft: Radius.circular(10),
                //                     topRight: Radius.circular(10)),
                //                 image: DecorationImage(
                //                     image:
                //                         AssetImage("assets/images/product_1.png"))),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.fromLTRB(defaultPadding,
                  //     defaultPadding * 2, defaultPadding, defaultPadding),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(defaultBorderRadius * 3),
                    //   topRight: Radius.circular(defaultBorderRadius * 3),
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '8:00 , 6:30',
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'کاتی ئیشکردن',
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.event_available),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.data['minimum'].toString(),
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'کەمترین بری داواکردن',
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.blueGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Icon(
                                    Icons.info_outline,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '(کرێی گەیاندن:5000 د.ع)',
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        'لە ماوەی 30 خەلەک',
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.watch_later_outlined),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'bihena',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: Text(
                                    'دەگەیەنرێت بەچاودێریکردنی ڕاستەوخۆ لەلایەن',
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.blueGrey,
                      ),

                      /// ama bo danany dashkandn
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     padding: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(10),
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: Colors.black45,
                      //               offset: Offset(0, 0.1),
                      //               blurRadius: 2)
                      //         ]),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Text(
                      //               'داشکاندنی ٪ 30 لەسەر تەواوی مینۆ',
                      //               style: TextStyle(
                      //                   color: Colors.redAccent, fontSize: 16),
                      //             ),
                      //             Text(
                      //               '20000 د.ع خەرج بکە',
                      //               textAlign: TextAlign.end,
                      //             )
                      //           ],
                      //         ),
                      //         SizedBox(
                      //           width: 15,
                      //         ),
                      //         Icon(
                      //           Icons.discount,
                      //           color: Colors.redAccent,
                      //           size: 20,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Divider(
                      //   color: Colors.blueGrey,
                      // ),
                      /// list title babatakan barhamakan
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: 40,
                      //   child: ListView.builder(
                      //     reverse: true,
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: demo_categories.length,
                      //     itemBuilder: (context, index) => TextButton(
                      //         onPressed: () {},
                      //         child: Text(
                      //           demo_categories[index].title,
                      //           style: TextStyle(
                      //               color: primaryColor, fontSize: 16),
                      //         )),
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height:  length * 130,
                        child: FutureBuilder(
                          future: _getdata(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: purpelprimary,
                                ),
                              );
                            }
                            if (snapshot.data == null) {
                              return Center(
                                child: Text(
                                    'هیچ بەرهەمێک بەردەست نییە لە ئێستەیا'),
                              );
                            }

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              //  controller: _controller,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data[index];

                                return (data['id_company']!=widget.data['id'])?Container():
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter
                                                    setState /*You can rename this!*/) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight: Radius.circular(25.0),
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                    "assets/images/product_0.png"),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 55,
                                                            height: 55,
                                                            child:
                                                                OutlinedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  _quantity +=
                                                                      1;
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color:
                                                                    primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            child: Text(
                                                              _quantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 55,
                                                            height: 55,
                                                            child:
                                                                OutlinedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (_quantity ==
                                                                      1) return;
                                                                  _quantity -=
                                                                      1;
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color:
                                                                    primaryColor,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            'جبسی من و تۆ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'د.ع ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                '250',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  child: const Text(
                                                    'هەڵگرتن',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                primaryColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 130,
                                    child: Card(
                                        color: index == 10 ? Colors.blue : null,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 110,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black45,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "$api/bihena/image/product_company/${data['image']}"),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        data['name'].toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 260,
                                                        child: Text(
                                                          data['about']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('د.ع '),
                                                      Text(data['nrx']
                                                          .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: const StadiumBorder()),
                            child: const Text("Add to Cart"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'کەمترین داواکاری : 5000 د.ع',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('د.ع ',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              Text('250',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                          Text(
                            'بینینی سەبەتە',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          // FloatingActionButton.small(
          //   onPressed: () => _animateToIndex(10),
          //   child: Icon(Icons.arrow_downward),
          // ),
        ],
      ),
    );
  }
}
