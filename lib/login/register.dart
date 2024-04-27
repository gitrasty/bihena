import 'dart:convert';

import 'package:debitpad/login/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/component.dart';
import 'package:http/http.dart' as http;

import '../shop/screens/home/home_screen.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  var _username = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _phone_number = TextEditingController();
  var _lan = TextEditingController();
  var _long = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _visible = false;
  bool? error = false, sending = false, success = false;
  String msg = '';

  Future register() async {
    String url = "http://192.168.0.107/bihena/register.php";
    var res = await http.post(Uri.parse(url), body: {
      'username': _username.text,
      'email': _email.text,
      'password': _password.text,
      'phone_number': _phone_number.text,
      'latitude': '0.0', //_lan.text,
      'longitude': '0.0', //_long.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      // print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString('email', _email.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        _username.text = '';
        _email.text = '';
        _password.text = '';
        _phone_number.text = '';
        _lan.text = '';
        _long.text = '';
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
   }


  bool? _login=false;
  Text? _text=null;
  Future _checklogin() async {
    var url = Uri.parse(
        'http://192.168.0.107/bihena/login/check_login.php');
    var response = await http.post(url);
    // print(response.body[1]['email'].toString());
    return jsonDecode(response.body);
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
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'خۆتۆمارکردن',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Visibility(
            visible: _visible,
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: LinearProgressIndicator(),
            ),
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
          SizedBox(
            height: 20.0,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _username,
                      validator: (value) {
                        if (!(value!.length > 3) && value.isEmpty) {
                          return "بە دروستی ناوەکەت بنوسە";
                        }
                      },
                      autocorrect: false,
                      style: TextStyle(
                        color: template,
                      ),
                      maxLength: 35,

                      decoration: InputDecoration(
                        counterText: "",

                        labelText: 'ناوی تەواوت',
                        labelStyle: TextStyle(fontSize: 18, color: template),

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
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _email,
                      validator: (value) =>  EmailValidator.validate(value.toString()) ? null : "بە دروستی ئیمەیلەکەت بنوسە",
                       autocorrect: false,
                      style: TextStyle(
                        color: template,
                      ),
                      maxLength: 40,
                      decoration: InputDecoration(
                        counterText: "",

                        labelText: 'ئیمەیل',
                        labelStyle: TextStyle(fontSize: 18, color: template),

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
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _password,
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
maxLength: 35,
                      decoration: InputDecoration(
                        counterText: "",

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
                        labelStyle: TextStyle(fontSize: 18, color: template),

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
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _phone_number,
                      validator: (value) {
                        if(value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)){
                          return "بە دروستی ژمارەکەت بنوسە بنوسە";
                        }
                        if (!RegExp(
                            r'^075').hasMatch(value)&&!RegExp(
                            r'^077').hasMatch(value)) {
                          return 'بە دروستی ژمارەکەت بنوسە بنوسە';
                        }

                        if (value.trim().length < 11) {
                          return 'بە دروستی ژمارەکەت بنوسە بنوسە 11 ژمارە کەمتر نەبێت';
                        }



                        },

                      autocorrect: false,
                      maxLength: 11,
                      style: TextStyle(
                        color: template,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: 'ژمارە مۆبایل',
                        hintText: "07#########",
                        labelStyle: TextStyle(fontSize: 18, color: template),

                        hintStyle: TextStyle(
                          color: Colors.blueGrey.shade100,
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
                  SizedBox(
                    height: 20,
                  ),
                  _text==null?Container():Center(child: _text),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: ()  {
                        // Validate returns true if the form is valid, or false otherwise.



                     if (_formKey.currentState!.validate()) {
                       setState(
                               (){
                             _checklogin().then((value) {
                               for(int i=0;i<value.length;i++){
                                 if(_email.text== value[i]['email']){
                                   _text=Text('پێشتر خۆت تۆمار کردووە چونە ژورەوە بکە');
                                   _login=false;
                                 }else{
                                   _login=true;
                                 }
                               }
                             });
                           }
                       );
                       if(_login==true)
                       register();
                     }
                      },
                      child: Text(
                        'خۆتۆمارکردن',
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
                      ),
                      minWidth: MediaQuery.of(context).size.width,
                      color: purpelprimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => login()));
                          },
                          child: Text(
                            'چونەژورەوە',
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
      )),
    );
  }
}
