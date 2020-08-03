import 'dart:convert';

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
    if (!_formKey.currentState.validate()) return;

    if (selectedDate == null) {
      setState(() {
        dobError = true;
      });
      return;
    }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SafeArea(child: Center()),
            Text("\nName"),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Enter Name";
                return null;
              },
              onChanged: (value) {
                name = value;
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  selectedDate == null
                      ? 'Set Date of Birth'
                      : "Change Date of birth",
                ),
              ),
            ),
            Text(
              selectedDate == null
                  ? "Date of birth hasn't been chosen"
                  : "DOB: " + selectedDate,
              style: TextStyle(color: dobError ? Colors.red : Colors.black),
            ),
            Text("\nAddress"),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Enter Address";
                return null;
              },
              onChanged: (value) {
                address = value;
              },
            ),
            Text("\nAadhar"),
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
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RaisedButton(
                child: Text("Save data"),
                onPressed: submitData,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
