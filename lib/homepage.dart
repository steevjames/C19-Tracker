import 'package:datacollect/collectdata.dart';
import 'package:datacollect/qrCode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = prefs.getString("userData");
    print("Data from homepage: $userData");
    return userData ?? "empty";
  }

  refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.data == "empty")
            return DataCollection(
              refreshParent: refreshPage,
            );
          return QRCodePage(
            userData: snapshot.data,
            refreshParent: refreshPage,
          );
        },
      ),
    );
  }
}
