import 'dart:convert';

import 'package:debitpad/component/component.dart';
import 'package:debitpad/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  var api = 'http://192.168.0.106';
  Future _getdata() async {
    var url = Uri.parse('http://192.168.0.106/instarast/');
    var response = await http.get(url);
   // print(response.body[1]['email'].toString());
    return jsonDecode(response.body);
  }

  Future _login(_email,_pass)async{
    var url = Uri.parse('http://192.168.0.106/instarast/login.php');
    var response = await http.post(url,body: {
      'email':_email,
      'password':_pass,
    });
    var data=json.decode(response.body);
    if(data=='success'){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => home_screen(),));
    }else{
      final snackBar = SnackBar(
        content: const Text(
            'email & password Incorrect'),
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'چوونەژورەوە',
          style: TextStyle(color: blueasent),
        ),
        backgroundColor: template,
      ),
      // backgroundColor: template,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              decoration: BoxDecoration(
                  color: Color(0xff7D8891),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(300.0))),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.15,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: template,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(350.0),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          height: 270,
                          decoration: BoxDecoration(
                              color: Color(0xff5E6B75),
                              borderRadius: BorderRadius.circular(15)),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8, top: 8),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: _email,
                                      validator: (value) {
                                        Pattern pattern =
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?)*$";
                                        RegExp regex =
                                            new RegExp(pattern.toString());
                                        if (!regex.hasMatch(value.toString()) ||
                                            value == null)
                                          return 'بە دروستی ئیمەیلەکەت بنوسە';
                                        else
                                          return null;
                                        // if (value!.isEmpty) {
                                        //   return "بە دروستی ئیمەیلەکەت بنوسە";
                                        // }
                                      },
                                      autocorrect: false,
                                      style: TextStyle(
                                        color: template,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'ئیمەیل',
                                        hintStyle: TextStyle(
                                          color: template,
                                        ),
                                        //    labelText: "Name",
                                        filled: true,

                                        fillColor: Colors.white, // blueasent,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          borderSide:
                                              BorderSide(color: template),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            borderSide:
                                                BorderSide(color: template)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            borderSide:
                                                BorderSide(color: template)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            borderSide: BorderSide(
                                              color: template,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,

                                      controller: _pass,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "بە دروستی وشەی تێپەڕەکەت بنوسە";
                                        }
                                      },
                                      autocorrect: false,
                                      style: TextStyle(
                                        color: template,
                                      ),
                                      obscureText:
                                          !_passwordVisible, //This will obscure text dynamically

                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        hintText: 'وشەی تێپەڕ',
                                        hintStyle: TextStyle(
                                          color: template,
                                        ),
                                        //    labelText: "Name",
                                        filled: true,
                                        fillColor: Colors.white, // blueasent,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          borderSide:
                                              BorderSide(color: template),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            borderSide:
                                                BorderSide(color: template)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            borderSide:
                                                BorderSide(color: template)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            borderSide: BorderSide(
                                              color: template,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  color: template,
                                  child: Text(
                                    'چوونەژورەوە',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  onPressed: () {

                                     try {
                                      if (!formkey.currentState!.validate()) {

                                      }else{
                                        _login(_email.text,_pass.text);
                                      }
                                    } catch (e) {
                                      formkey.currentState!.validate();
                                    }
                                  },
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
