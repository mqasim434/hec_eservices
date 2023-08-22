import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/UserModel.dart';

class GetData extends StatefulWidget {
  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  bool isLoading = false;
  String fName = 'null';

  String lName = 'null';

  String cnic = 'null';

  String county = 'null';

  String ccnic = "34201";

  Future<dynamic> getUserData() async {
    isLoading = true;
    try {
      var endPoint = "http://192.168.149.61:80/getUser34201";
      var url = Uri.parse(endPoint);
      var user = await http.get(url);

      if (user.statusCode == 200) {
        UserModel currentUser = UserModel.fromJson(json.decode(user.body));
        setState(() {
          fName = currentUser.firstName.toString();
          lName = currentUser.lastName.toString();
          cnic = currentUser.cnic.toString();
          county = currentUser.country.toString();
        });
        isLoading = false;
      } else {
        print('User Not Found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get User'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: isLoading==true
              ? CircularProgressIndicator(color: Colors.red,)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      fName,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      lName,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      cnic,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      county,
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getUserData();
                        },
                        child: Text('GET DATA')),
                  ],
                ),
        ),
      ),
    );
  }
}
