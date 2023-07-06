import 'package:flutter/material.dart';
import 'package:flutterv1/json_list/usermodel.dart';

import '../json_list/userviewmodel.dart';

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State {
  List dataUser = [];
  void getDataUser() {
    UserViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

   Widget personDetailCard(UserModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          showDetailDialog(data);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.name,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 8.0),
                Text(
                  data.username,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(height: 8.0),
                Text(
                  data.email,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  showDetailDialog(UserModel data) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Detail Person',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Name: ${data.name}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Email: ${data.email}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Username: ${data.username}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Website: ${data.website}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Utama"),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return personDetailCard(dataUser[i]);
          },
          itemCount: dataUser.length,
        ),
      ),
    );
  }
}