import 'package:flutter/material.dart';

class PageMINavigatorBar extends StatelessWidget {
  const PageMINavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(
            'Manajemen Informatika',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,// Mengatur warna teks menjadi putih
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white), // Mengatur warna ikon menjadi putih
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Set ke atas
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Menambah jarak dari atas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Menambah padding horizontal
                  child: Text(
                    'Deskripsi',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Menambah jarak antara "Deskripsi" dan teks berikutnya
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0), // Menambah padding horizontal
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Menambah margin
                    child: Text(
                      'Program Studi Manajemen Informatika (Kampus Kab. Pelalawan merupakan salah satu Program Studi Diluar Kampus Utama (PSDKU) Politeknik Negeri Padang yang memiliki sejarah dan keterkaitan erat dengan berdirinya Akademi Komunitas di Daerah Pelalawan. Berangkat dari SK Pendirian AKademi Komunitas Nomor : 179/P/2013 Tanggal 26 September 2013, Program Studi Diluar Kampus Domisili (PDD) Kabupaten Pelalawan di awal berdirinya memiliki Program Studi D2 Elektro Industri dan D2 Manajemen Informatika.',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify, // Menjadikan teks rata kanan kiri
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      //back ke page sebelumnya
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
