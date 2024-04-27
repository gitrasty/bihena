import 'dart:convert';

import 'package:debitpad/component/component.dart';
import 'package:debitpad/login/login.dart';
import 'package:debitpad/shop/constants.dart';
import 'package:debitpad/shop/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
   String? name='';

    HomeScreen({Key? key,this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var api = 'http://192.168.0.107';
  Future _getdata() async {
    var url = Uri.parse(
        'http://192.168.0.107/bihena/company_author/company_author.php');
    var response = await http.post(url);
    // print(response.body[1]['email'].toString());
    return jsonDecode(response.body);
  }


  int  length=2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(children: [
          ListTile(onTap: ()async{
            SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
            sharedPreferences.remove('email' );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => login(),));

          },
          title: Text('دەرچوون'),
          leading: Icon(Icons.logout),
          )
        ],),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
         widget.name.toString(),// "Bihena",
          style: TextStyle(fontWeight: FontWeight.bold, color: purpelprimary),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.search)),
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Form(
              child: TextFormField(
                onSaved: (value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search items...",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: purpelprimary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: () {},
                        child: Center(child: Icon(Icons.filter_list)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Container(child: const Categories()),

          Container(
              width: MediaQuery.of(context).size.width,
              height: length * 255,
              child: FutureBuilder(
                future: _getdata(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: purpelprimary,
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                          'ببورە کۆمپانیاکان بەردەس نین بەم زوانە کۆمپانیای نوێ دا ئەنێین . کاتێکی خۆش'),
                    );
                  }
                  length = snapshot.data.length;

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsScreen(data: data,),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 154,
                            height: 250,
                            padding: const EdgeInsets.all(defaultPadding / 2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(defaultBorderRadius)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.blueGrey.shade100, //bgColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(defaultBorderRadius)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "$api/bihena/image/profile/${data['image']}"),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                Text(
                                  data['username'],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${data['minimum']} کەمترین داواکاری ',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    Text(
                                      'ماوەی گەیاندن 30 - 45 خولەک',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: defaultPadding / 4)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )),
          Container(
              width: MediaQuery.of(context).size.width,
              height:   230,
              child:   GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsScreen(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 154,
                            height: 20,
                            padding: const EdgeInsets.all(defaultPadding / 2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(defaultBorderRadius)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      color:
                                      lodingColor, //bgColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(defaultBorderRadius)),

                                  ),
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                Container(
                                  width: 100,
                                  height: 10,
                                  color: lodingColor),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        width: 300,
                                        height: 10,
                                        color: lodingColor),
                                    ),
                                    Container(
                                      width: 250,
                                     height: 10,
                                    color: lodingColor),
                                  ],
                                ),
                                const SizedBox(width: defaultPadding / 4)
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
          // const NewArrivalProducts(),
          //  const xwardnawa_gazyyanakan(),

          SizedBox(
            height: 30,
          )
        ],
      ),

    );
  }
}
