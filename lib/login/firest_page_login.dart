import 'package:debitpad/login/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../component/component.dart';

class firest_page_login extends StatefulWidget {
  const firest_page_login({Key? key}) : super(key: key);

  @override
  State<firest_page_login> createState() => _firest_page_loginState();
}

class _firest_page_loginState extends State<firest_page_login> {

  googelsignin()async{
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
  var result=    await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: purpelprimary,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          'D',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 90,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(

                    'Dawayka',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: purpelprimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ), ],
            ),
            SizedBox(height: 10,),
            Column(
              children: [


                Center(child: Card(
                  color: Colors.blue,
                  child: ListTile(
                    title: Text('چوونەژورەوە بە فەیسبووک'
                      ,textAlign: TextAlign.end
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                    leading: Icon(FontAwesomeIcons.facebookF  ,color: Colors.white,),
                  ),
                ),
                ),
                Center(child: Card(

                  child: ListTile(
                    title: Text('چونەژورەوە نە گۆگڵ'                      ,textAlign: TextAlign.end
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  leading: Icon(FontAwesomeIcons.google ,color: Colors.pink,),
                  ),
                ),
                ),

                Center(child: Card(
                  child: ListTile(
                    title: Text('چونەژورەوە بە ئیمەیل'                      ,textAlign: TextAlign.end
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    leading: Icon(FontAwesomeIcons.envelope  ),

               onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => login(),));
               },   ),
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
