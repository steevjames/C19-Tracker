import 'dart:convert';
import 'package:datacollect/Pages/Widgets/appbarCurve.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodePage extends StatelessWidget {
  final String userData;
  final Function refreshParent;

  QRCodePage({@required this.userData, @required this.refreshParent});

  final Color primaryColor = Colors.blue;

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

    String address = userJSON["Address"].length > 20
        ? userJSON["Address"].substring(0, 20) + "...."
        : userJSON["Address"];
    address = address.replaceAll("\n", " ");
    String aadhar = userJSON["Aadhar"];
    return Scaffold(
      appBar: AppBar(
        title: Text("C19 Tracker"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        shape: CustomShapeBorder(),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        //   onPressed: clearData,
        // ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Image.asset("assets/icon.png", width: 60),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getRow(name, Icons.person),
                    getRow(dob, Icons.date_range),
                    getRow(address, Icons.place),
                    getRow(aadhar, Icons.confirmation_number)
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            QrImage(
              data: userData,
              backgroundColor: Color(0xff333344),
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 40),
            RaisedButton(
              child: Text("Change information"),
              onPressed: clearData,
              color: primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 18,
            color: Color(0xff333344),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              color: Color(0xff333344),
            ),
          ),
        ],
      ),
    );
  }
}
