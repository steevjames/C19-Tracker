import 'dart:convert';
import 'package:datacollect/Pages/Widgets/appbarCurve.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCollection extends StatefulWidget {
  final Function refreshParent;
  DataCollection({@required this.refreshParent});
  @override
  _DataCollectionState createState() => _DataCollectionState();
}

class _DataCollectionState extends State<DataCollection> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String address;
  String aadhar;
  String selectedDate;
  bool dobError = false;
  Map<String, String> result;
  Color primaryColor = Colors.blue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1999),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2050),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked.year.toString().padLeft(2, '0') +
            "-" +
            picked.month.toString().padLeft(2, '0') +
            "-" +
            picked.day.toString().padLeft(2, '0');
      });
    print(selectedDate);
  }

  submitData() async {
    setState(() {
      dobError = false;
    });

    if (selectedDate == null) {
      setState(() {
        dobError = true;
      });
    }

    if (!_formKey.currentState.validate() || selectedDate == null) return;

    result = {
      "Name": name,
      "DOB": selectedDate,
      "Address": address,
      "Aadhar": aadhar,
    };
    print("Userdata from form \n$result");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userData", jsonEncode(result));
    widget.refreshParent();
  }

  InputDecoration inpDec(text, icon) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      labelText: text,
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      labelStyle: TextStyle(fontSize: 13),
      icon: Icon(icon, color: primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "C19 Tracker",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SafeArea(child: Center()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  "assets/icon.png",
                  height: 90,
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Enter Name";
                  return null;
                },
                onChanged: (value) {
                  name = value;
                },
                decoration: inpDec("Name", Icons.person),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.date_range,
                    color: primaryColor,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        selectedDate == null ? "Choose DOB" : selectedDate,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: dobError ? Colors.red : primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Enter Address";
                  return null;
                },
                onChanged: (value) {
                  address = value;
                },
                decoration: inpDec("Address", Icons.place),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Enter Aadhar";
                  if (value.length != 12) return "Enter valid Aadhar";
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  aadhar = value;
                },
                decoration: inpDec("Aadhar", Icons.confirmation_number),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text("Save data"),
                onPressed: submitData,
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
      ),
    );
  }
}
