import 'package:flutter/material.dart';
import 'package:flutterv1/models/model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../viewmodels/user_vm.dart';
import 'home.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late final TextEditingController _textIDController;
  late final TextEditingController _textNameController;
  late final TextEditingController _textEmailController;
  late final TextEditingController _textPassController;
  late final TextEditingController _textRePassController;
  late String email = "";
  late String password = "";
  late String name = "";
  late String reTypePassword = "";

  @override
  void initState() {
    super.initState();
    _textIDController = TextEditingController(text: widget.user.id);
    _textNameController = TextEditingController(text: widget.user.name);
    _textEmailController = TextEditingController(text: widget.user.email);
    _textPassController = TextEditingController(text: widget.user.password);
    _textRePassController = TextEditingController(text: widget.user.password);
    name = widget.user.name;
    email = widget.user.email;
    password = widget.user.password;
    reTypePassword = widget.user.password;
  }

  void updateUser() async {
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
        UserViewModel()
            .editUser(widget.user.id, name, email, password)
            .then((value) {
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
      appBar: AppBar(title: const Text("Edit User")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("ID"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textIDController,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => name = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Nama Lengkap"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textNameController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => name = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Email Address"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textEmailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => email = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Password"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textPassController,
                obscureText: true,
                onChanged: (e) => password = e,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Retype Password"),
            SizedBox(
              height: 25,
              child: TextField(
                controller: _textRePassController,
                obscureText: true,
                onChanged: (e) => reTypePassword = e,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  updateUser();
                },
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
