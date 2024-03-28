import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "../model/model_berita.dart";
import 'package:http/http.dart' as http;

class DetailBerita extends StatelessWidget {
  final Datum? data;
  const DetailBerita(this.data, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "http://172.20.10.3/beritaDb/gambar_berita/${data?.gambarBerita}",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(
              DateFormat().format(data?.tglBerita ?? DateTime.now()),
            ),
            trailing: const Icon(
              Icons.star,
              color: Colors.red,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: Text(
              data?.isiBerita ?? "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});
  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  Future<List<Datum>?> getBerita() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://172.20.10.3/beritaDb/getBerita.php"));
      return modelBeritaFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getBerita(),
        builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Datum? data = snapshot.data?[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        //ini untuk ke detail
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailBerita(data)));
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://172.20.10.3/beritaDb/gambar_berita/${data?.gambarBerita}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "${data?.judul}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: 18),
                              ),
                              subtitle: Text(
                                "${data?.isiBerita}",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }
        },
      ),
    );
  }
}
