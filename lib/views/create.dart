import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterv1/views/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/model.dart';
import '../viewmodels/user_vm.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  late String email = "";
  late String password = "";
  late String name = "";
  late String reTypePassword = "";

  void register() async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Fluttertoast.showToast(
        msg: "Semua Field harus diisi dengan data yang benar!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.yellow[300],
        textColor: Colors.red,
      );
    } else {
      if (password != reTypePassword) {
        Fluttertoast.showToast(
          msg: "Password yang anda masukkan tidak sama!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.red,
        );
      } else {
        showLoaderDialog(context);
        UserViewModel().createUser(name, email, password).then((value) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        });
      }
    }
  }

  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 7),
          Text("Loading..."),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah User baru")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Nama Lengkap"),
            SizedBox(
              height: 25,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => name = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Email Address"),
            SizedBox(
              height: 25,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => email = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Password"),
            SizedBox(
              height: 25,
              child: TextField(
                obscureText: true,
                onChanged: (e) => password = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Retype Password"),
            SizedBox(
              height: 25,
              child: TextField(
                obscureText: true,
                onChanged: (e) => reTypePassword = e,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  register();
                },
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
