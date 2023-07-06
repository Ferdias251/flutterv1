import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    const SharedPrefScreen(),
  );
}

class SharedPrefScreen extends StatefulWidget {
  const SharedPrefScreen({Key? key}) : super(key: key);

  @override
  State<SharedPrefScreen> createState() => _SharedPrefScreenState();
}

class _SharedPrefScreenState extends State<SharedPrefScreen> {
  int counter = 0;
  bool isDark = false;

  void minus() {
    counter = counter - 1;
    setPreference();
  }

  void add() {
    counter = counter + 1;
    setPreference();
  }

  void changeTheme() {
    isDark = !isDark;
    setPreference();
  }

  void refresh() {
    counter = 0;
    isDark = false;
    setPreference();
  }

  Future<void> setPreference() async {
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // untuk mengambil data dan memaasukkan data kedalam storage
    if (pref.containsKey('myData')) {
      pref.clear();
    } // setiap menjalankan function di clear dulu datanya
    final myData = jsonEncode({
      'counter': counter.toString(),
      'isDark': isDark.toString(),
    });
    pref.setString('myData', myData);
    setState(() {});
  }

//GetPreference
  Future<void> getPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('myData')) {
      final myData =
          json.decode(pref.getString('myData')!) as Map<String, dynamic>;

      counter = int.parse(myData["counter"]);
      isDark = myData['isDark'] == "true" ? true : false;
    }
  }

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff39A2DB),
    primarySwatch: Colors.amber,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: const BorderSide(
          color: Colors.white,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
  ThemeData bright = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff39A2DB),
    primarySwatch: Colors.amber,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: const BorderSide(
          color: Colors.black,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
  // OutlinedButtonThemeData ); // ThemeData
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreference(),
        builder: (context, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: isDark ? dark : bright,
              home: Scaffold(
                appBar: AppBar(
                  title: const Text('Counter Apps'),
                  actions: [
                    IconButton(
                        onPressed: refresh, icon: const Icon(Icons.refresh))
                  ],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Angka saat ini adalah : $counter',
                        style: const TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () => minus(),
                            child: const Icon(Icons.remove),
                          ),
                          OutlinedButton(
                            onPressed: () => add(),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => changeTheme(),
                  child: const Icon(Icons.color_lens),
                ),
              ),
            ));
  }
}
