import 'package:flutter/material.dart';

class DetailGrid extends StatelessWidget {
  final Map<String, dynamic> movieDetails;

  const DetailGrid(this.movieDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(movieDetails["judul"]),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "gambar/${movieDetails["gambar"]}",
                    width: 200,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Judul: ${movieDetails["judul"]}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Harga: Rp. ${movieDetails["harga"]}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            ),
        );
    }
}


class PageCustomeGrid extends StatefulWidget {
  const PageCustomeGrid({key}) : super(key: key);

  @override
  State<PageCustomeGrid> createState() => _PageCustomeGridState();
}

class _PageCustomeGridState extends State<PageCustomeGrid> {
  List<Map<String, dynamic>> listMovie = [
    {
      "judul": "Oppenheimer",
      "gambar": "movie1.jpg",
      "harga": 45000,
    },
    {
      "judul": "Inception",
      "gambar": "movie2.jpg",
      "harga": 35000,
    },
    {
      "judul": "The Dark Knight",
      "gambar": "movie3.jpg",
      "harga": 50000,
    },
    {
      "judul": "Tenet",
      "gambar": "movie4.jpg",
      "harga": 45000,
    },
    {
      "judul": "Interstellar",
      "gambar": "movie5.jpg",
      "harga": 35000,
    },
    {
      "judul": "The Prestige",
      "gambar": "movie6.jpg",
      "harga": 45000,
    },
    {
      "judul": "Ciao Alberto",
      "gambar": "movie1.jpg",
      "harga": 45000,
    },
    {
      "judul": "The Simpson",
      "gambar": "movie2.jpg",
      "harga": 35000,
    },
    {
      "judul": "Jungle Cruise",
      "gambar": "movie3.jpg",
      "harga": 50000,
    },
    {
      "judul": "Home Alone",
      "gambar": "movie4.jpg",
      "harga": 45000,
    },
    {
      "judul": "Korea Action",
      "gambar": "movie5.jpg",
      "harga": 35000,
    },
    {
      "judul": "A Monster Calls",
      "gambar": "movie6.jpg",
      "harga": 45000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Grid"),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        itemCount: listMovie.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailGrid(listMovie[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridTile(
                footer: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${listMovie[index]["judul"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text("Rp. ${listMovie[index]["harga"]}"),
                    ],
                  ),
                ),
                child: Image.asset("gambar/${listMovie[index]["gambar"]}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
