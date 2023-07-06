import 'package:flutter/material.dart';
import 'package:flutterv1/Mahasiswa.dart';

void main() {
  runApp(
    const CardViewScreen(),
  );
}
class CardViewScreen extends StatefulWidget {
  const CardViewScreen({Key? key}) : super(key: key);

  @override
  State<CardViewScreen> createState() => _CardViewScreenState();
}

class _CardViewScreenState extends State<CardViewScreen> {
  @override
  List<Mahasiswa> mhs = [
    Mahasiswa(
      name: 'AMIRUDIN ROMADHONI',
      nim: 'D111232323', 
      tahun: 2017, 
      prodi: 'Informatika', 
      profileImg: 'https://blog.evermos.com/wp-content/uploads/2023/01/98c15480aadf98043c87b4d01b1b5e1d.jpg',
      ),
      Mahasiswa(
      name: 'EVELIN KHOIRUNISSA',
      nim: 'D111232324', 
      tahun: 2017, 
      prodi: 'Informatika', 
      profileImg: 'https://divedigital.id/wp-content/uploads/2022/08/bermasker.jpg',
      ),
      Mahasiswa(
      name: 'FIRDA NUR ISTANAH',
      nim: 'D111232325', 
      tahun: 2017, 
      prodi: 'Informatika', 
      profileImg: 'https://i0.wp.com/dianisa.com/wp-content/uploads/2022/08/6.-Profil-WA-Illustrasi.jpg?resize=1000%2C580&ssl=1',
      ),
  ];
  Widget personDetailCard(Mahasiswa p){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(p.profileImg)
                      ),
                  ),
                ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      p.name,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      p.nim,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      p.prodi,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const[
                Icon(Icons.notifications_none, size: 35, color: Colors.white),
                Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Icon(Icons.notifications_none, size: 35, color: Colors.white),
              ],
            ),
            Column(
              children: mhs.map((p) {
                return personDetailCard(p);
              }).toList())
          ],
        ),
        ),
    );
  }
}