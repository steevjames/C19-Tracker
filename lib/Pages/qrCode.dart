import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodePage extends StatelessWidget {
  final String userData;
  final Function refreshParent;
  QRCodePage({@required this.userData, @required this.refreshParent});

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userData", null);
    refreshParent();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userJSON = jsonDecode(userData);
    String name = userJSON["Name"];
    String dob = userJSON["DOB"];
    String address = userJSON["Address"];
    String aadhar = userJSON["Aadhar"];
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SafeArea(child: Center()),
          Center(
            child: Text(
              "\n\nName:  $name\nDate of birth: $dob\nAddress: $address\nAadhar: $aadhar\n",
            ),
          ),
          Center(
            child: QrImage(
              data: userData,
              size: min(MediaQuery.of(context).size.width * .8,
                  MediaQuery.of(context).size.height * .8),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: RaisedButton(
              child: Text("Clear Data"),
              onPressed: clearData,
            ),
          )
        ],
      ),
    );
  }
}
