import 'dart:convert';

import 'package:debitpad/component/component.dart';
import 'package:debitpad/login/register.dart';
import 'package:debitpad/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../shop/screens/home/home_screen.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var _email = TextEditingController();
  var _pass = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var _passwordVisible = false;
  //
  // var api = 'http://192.168.0.106';
  // Future _getdata() async {
  //   var url = Uri.parse('http://192.168.0.106/instarast/');
  //   var response = await http.get(url);
  //  // print(response.body[1]['email'].toString());
  //   return jsonDecode(response.body);
  // }
  //
  // Future _login(_email,_pass)async{
  //   var url = Uri.parse('http://192.168.0.106/instarast/login.php');
  //   var response = await http.post(url,body: {
  //     'email':_email,
  //     'password':_pass,
  //   });
  //   var data=json.decode(response.body);
  //   if(data=='success'){
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => home_screen(),));
  //   }else{
  //     final snackBar = SnackBar(
  //       content: const Text(
  //           'email & password Incorrect'),
  //     );
  //
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(snackBar);
  //   }
  //
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // _getdata();
  // }

  bool _visible = false;

  //Textediting Controller for Username and Password Input

  Future userLogin() async {
    //Login API URL
    //use your local IP address instead of localhost or use Web API
    String url = "http://192.168.0.107/bihena/login.php";

    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    // Getting username and password from Controller
    var data = {
      'email': _email.text,
      'password': _pass.text,
    };

    //Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['loginStatus'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', _email.text);
        // Navigate to Home Screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(name: msg['userInfo']['username'])));
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }

  showMessage(String _msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_msg),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'چوونەژورەوە',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // backgroundColor: template,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: LinearProgressIndicator(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            // Container(
            //   padding: EdgeInsets.zero,
            //   height: 160,
            //   width: MediaQuery.of(context).size.width / 2.5,
            //   decoration: BoxDecoration(
            //     color: purpelprimary,
            //     borderRadius: BorderRadius.circular(200),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Center(
            //         child: Text(
            //           'D',
            //           textAlign: TextAlign.end,
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 90,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10,),
            // Center(
            //   child: Text(
            //
            //     'Dawayka',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: purpelprimary,
            //         fontSize: 22,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Theme(
                      data: new ThemeData(
                        primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                        hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "بە دروستی ئیمەیلەکەت بنوسە";
                            }
                          },
                          autocorrect: false,
                          style: TextStyle(
                            color: template,
                          ),
                          decoration: InputDecoration(
                            labelText: 'ئیمەیل',
                            labelStyle:
                                TextStyle(fontSize: 18, color: template),

                            hintStyle: TextStyle(
                              color: template,
                            ),
                            //    labelText: "Name",
                            filled: true,
                            fillColor: Colors.white, // blueasent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: template),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: template)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: template)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: template,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                        hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _pass,
                          validator: (value) {
                            if ( value!.isEmpty) {
                              return "بە دروستی وشەی تێپەڕ بنوسە";
                            }
                            if (value.trim().length < 6) {
                              return 'وشەی نهێنی لە ٦ پیت کەمتر نەبێت';
                            }
                          },
                          autocorrect: false,
                          style: TextStyle(
                            color: template,
                          ),
                          obscureText: _isObscure,

                          decoration: InputDecoration(

                            suffixIcon: GestureDetector(onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                              child: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                            labelText: 'وشەی نهێنی',
                            labelStyle:
                                TextStyle(fontSize: 18, color: template),

                            hintStyle: TextStyle(
                              color: template,
                            ),
                            //    labelText: "Name",
                            filled: true,
                            fillColor: Colors.white, // blueasent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: template),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: template)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: template)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: template,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () => {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {userLogin()}
                        },
                        child: Text(
                          'چوونەژورەوە',
                          style: TextStyle(fontSize: 28.0, color: Colors.white),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        color: purpelprimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {     Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => register()));
                            },
                            child: Text(
                              'خۆتۆمارکردن',
                              style: TextStyle(
                                  color: purpelprimary,
                                  fontWeight: FontWeight.bold,
                              fontSize: 18),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'وشەی نهێنیی لەبیر چووەتەوە',
                              style: TextStyle(
                                  color: purpelprimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                      ],
                    ),
                   ],
                ),
              ),
            ),
          ],
        ),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: MediaQuery.of(context).size.height / 1.15,
      //         decoration: BoxDecoration(
      //             color: Color(0xff7D8891),
      //             borderRadius:
      //                 BorderRadius.only(bottomLeft: Radius.circular(300.0))),
      //         child: Container(
      //           width: MediaQuery.of(context).size.width,
      //           height: MediaQuery.of(context).size.height / 1.15,
      //           margin: EdgeInsets.only(bottom: 30),
      //           decoration: BoxDecoration(
      //             color: template,
      //             borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(350.0),
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Container(
      //                     width: MediaQuery.of(context).size.width / 1,
      //                     height: 270,
      //                     decoration: BoxDecoration(
      //                         color: Color(0xff5E6B75),
      //                         borderRadius: BorderRadius.circular(15)),
      //                     child: Form(
      //                       key: formkey,
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.only(
      //                                 right: 8.0, left: 8, top: 8),
      //                             child: Directionality(
      //                               textDirection: TextDirection.rtl,
      //                               child: TextFormField(
      //                                 controller: _email,
      //                                 validator: (value) {
      //                                   Pattern pattern =
      //                                       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      //                                       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      //                                       r"{0,253}[a-zA-Z0-9])?)*$";
      //                                   RegExp regex =
      //                                       new RegExp(pattern.toString());
      //                                   if (!regex.hasMatch(value.toString()) ||
      //                                       value == null)
      //                                     return 'بە دروستی ئیمەیلەکەت بنوسە';
      //                                   else
      //                                     return null;
      //                                   // if (value!.isEmpty) {
      //                                   //   return "بە دروستی ئیمەیلەکەت بنوسە";
      //                                   // }
      //                                 },
      //                                 autocorrect: false,
      //                                 style: TextStyle(
      //                                   color: template,
      //                                 ),
      //                                 decoration: InputDecoration(
      //                                   hintText: 'ئیمەیل',
      //                                   hintStyle: TextStyle(
      //                                     color: template,
      //                                   ),
      //                                   //    labelText: "Name",
      //                                   filled: true,
      //
      //                                   fillColor: Colors.white, // blueasent,
      //                                   border: OutlineInputBorder(
      //                                     borderRadius:
      //                                         BorderRadius.circular(0.0),
      //                                     borderSide:
      //                                         BorderSide(color: template),
      //                                   ),
      //                                   disabledBorder: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(0.0),
      //                                       borderSide:
      //                                           BorderSide(color: template)),
      //                                   enabledBorder: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(0.0),
      //                                       borderSide:
      //                                           BorderSide(color: template)),
      //                                   focusedBorder: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(0.0),
      //                                       borderSide: BorderSide(
      //                                         color: template,
      //                                       )),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: 5,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(
      //                                 right: 8.0, left: 8),
      //                             child: Directionality(
      //                               textDirection: TextDirection.rtl,
      //                               child: TextFormField(
      //                                 keyboardType:
      //                                     TextInputType.visiblePassword,
      //
      //                                 controller: _pass,
      //                                 validator: (value) {
      //                                   if (value!.isEmpty) {
      //                                     return "بە دروستی وشەی تێپەڕەکەت بنوسە";
      //                                   }
      //                                 },
      //                                 autocorrect: false,
      //                                 style: TextStyle(
      //                                   color: template,
      //                                 ),
      //                                 obscureText:
      //                                     !_passwordVisible, //This will obscure text dynamically
      //
      //                                 decoration: InputDecoration(
      //                                   suffixIcon: IconButton(
      //                                     icon: Icon(
      //                                       // Based on passwordVisible state choose the icon
      //                                       _passwordVisible
      //                                           ? Icons.visibility
      //                                           : Icons.visibility_off,
      //                                       color: Theme.of(context)
      //                                           .primaryColorDark,
      //                                     ),
      //                                     onPressed: () {
      //                                       // Update the state i.e. toogle the state of passwordVisible variable
      //                                       setState(() {
      //                                         _passwordVisible =
      //                                             !_passwordVisible;
      //                                       });
      //                                     },
      //                                   ),
      //                                   hintText: 'وشەی تێپەڕ',
      //                                   hintStyle: TextStyle(
      //                                     color: template,
      //                                   ),
      //                                   //    labelText: "Name",
      //                                   filled: true,
      //                                   fillColor: Colors.white, // blueasent,
      //                                   border: OutlineInputBorder(
      //                                     borderRadius:
      //                                         BorderRadius.circular(0.0),
      //                                     borderSide:
      //                                         BorderSide(color: template),
      //                                   ),
      //                                   disabledBorder: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(0.0),
      //                                       borderSide:
      //                                           BorderSide(color: template)),
      //                                   enabledBorder: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(0.0),
      //                                       borderSide:
      //                                           BorderSide(color: template)),
      //                                   focusedBorder: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(0.0),
      //                                       borderSide: BorderSide(
      //                                         color: template,
      //                                       )),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           MaterialButton(
      //                             color: template,
      //                             child: Text(
      //                               'چوونەژورەوە',
      //                               style: TextStyle(
      //                                   color: Colors.white, fontSize: 22),
      //                             ),
      //                             onPressed: () {
      //
      //                                try {
      //                                 if (!formkey.currentState!.validate()) {
      //
      //                                 }else{
      //                                   _login(_email.text,_pass.text);
      //                                 }
      //                               } catch (e) {
      //                                 formkey.currentState!.validate();
      //                               }
      //                             },
      //                           )
      //                         ],
      //                       ),
      //                     )),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      //
    );
  }
}
