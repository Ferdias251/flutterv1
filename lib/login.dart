import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const Login(),
  );
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginToSystem() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Username dan password tidak boleh kosong",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red[800],
        textColor: Colors.white,
      );
      return;
    }

    showLoaderDialog(context, 30);

    final response = await http.post(
      Uri.parse("http://192.168.1.5/ferdi/login.php"),
      body: jsonEncode({"username": email, "password": password}),
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String resStatus = responseData["message"];

      if (resStatus == "Login berhasil") {
        bool _isLogin = true;
        if (_rememberMe) saveDataLogin(_isLogin, email);

        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login berhasil"),
              content: Text("Selamat datang $resStatus"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    child: TextButton(
                      child: const Text("OK"),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.green,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        launch(
                            'https://drive.google.com/file/d/1Off1quNrA9vnkbX659uKdk4N0pu8aHMS/view');
                      },
                    ),
                  ),
                )
              ],
            );
          },
        );
      } else {
        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Gagal"),
              content: const Text("Username atau password salah. \r\nSilahkan coba lagi!!"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    child: TextButton(
                      child: const Text("OK"),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.green,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Gagal terhubung ke server",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red[800],
        textColor: Colors.white,
      );
    }
  }

  void showLoaderDialog(BuildContext context, int _period) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          ),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Timer? _timer;
        _timer = Timer(Duration(seconds: _period), () {
          Navigator.of(context).pop();
          if (_timer != null && _timer.isActive) {
            _timer.cancel();
          }
        });

        return WillPopScope(
          onWillPop: () async {
            if (_timer != null && _timer.isActive) {
              _timer.cancel();
            }
            return true;
          },
          child: alert,
        );
      },
    );
  }

  Future<void> saveDataLogin(bool _isLogin, String dataLogin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLogin', _isLogin);
    await pref.setString("username", dataLogin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                Text('Remember Me'),
              ],
            ),
            ElevatedButton(
              onPressed: loginToSystem,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
