import 'dart:convert';

import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editProfileScreen.dart';
import 'homeScreen.dart';

class VoirPubs extends StatefulWidget{
  @override
  _VoirPubsState createState() => _VoirPubsState();
}

class _VoirPubsState extends State<VoirPubs> {

  TextEditingController messageController = TextEditingController();

  bool _isLoading = false;
  List ListpublicationData = [];
  var publicationData;
  @override
  void initState() {
    _getPubInfo();
    super.initState();
  }

  void _getPubInfo() async {
    /*SharedPreferences localStorage = await SharedPreferences.getInstance();
    var pubJson = localStorage.getString('publication_show');
    var pub = json.decode(pubJson);
    setState(() {
      publicationData = pub;
    });*/
    //print(pubJson);
    var res = await CallApi().getData('publication_show');
    //print(res);
    var body = json.decode(res.body);
    //print(body);
    setState(() {
      ListpublicationData = body;
      //print(ListpublicationData.length);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Application'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.grey[200],
      body: ListpublicationData.length > 0
          ? ListView.builder(
        itemCount: ListpublicationData.length,
        itemBuilder: (BuildContext context, int index) {
          /*return ListTile(
            title: Text(ListpublicationData[index]['message']),
          );*/
          return Container(
              child: Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              ////////////// 1st card///////////
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.only(left: 10, right: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
          child: Padding(
          padding: const EdgeInsets.only(
          left: 10, right: 10, top: 40, bottom: 40),
          child:
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              /*elevation: 4.0,
              color: Colors.white,
              margin: EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),*/
              child: Container(
                padding:
                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        /*Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.account_circle,
                            color: Color(0xFFFF835F),
                          ),
                        ),*/
                        Text(
                          //'Message',
                          ListpublicationData[index]['message'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF9b9b9b),
                            fontSize: 17.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /////////// Edit Button /////////////
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Text(
                                  'Supprimer',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              color: Color(0xFFFF835F),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0)),
                              onPressed: _publish
                            ),
                          ),

                        ],
                      ),
                    )
                    /*Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        //userData!= null ? '${userData['name']}' :
                        ListpublicationData[index]['message'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ]
          )
          )
              )]
          )
                  )
              )
          );
        },
      )
          : Center(child: const Text('No items')),

    );
  }

  void _publish() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'message' : messageController.text,
    };

    var res = await CallApi().postData(data, 'publish');
    //var body = json.decode(res.body);
/*    print(body);
    if (body['success'] == true) {
      //print(body['user']);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));*/

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Home()));
    //}


    setState(() {
      _isLoading = false;
    });

  }

}

