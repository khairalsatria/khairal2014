import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khairal2014/lat_model/model_pegawai.dart';
import 'package:http/http.dart' as http;
import 'package:khairal2014/lat_screen.page/lat_page_login_api.dart';
import 'package:khairal2014/lat_screen.page/lat_update_pegawai.dart';
import 'package:khairal2014/utils/lat_session_manager.dart';

class PageListPegawai extends StatefulWidget {
  const PageListPegawai({super.key});

  @override
  State<PageListPegawai> createState() => _PageListPegawaiState();
}

class _PageListPegawaiState extends State<PageListPegawai> {
  @override
  TextEditingController searchController = TextEditingController();
  List<Datum>? pegawaiList;
  List<Datum>? filteredPegawaiList;

  Future<List<Datum>> getPegawai() async {
    try {
      final response = await http
          .get(Uri.parse("http://192.168.100.238/edukasi_server/getPegawai.php"));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['isSuccess'] == true) {
          return List<Datum>.from(
              jsonResponse['data'].map((x) => Datum.fromJson(x)));
        } else {
          throw Exception('Failed to load data: ${jsonResponse['message']}');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  List<Datum> filterPegawai(List<Datum> pegawaiList, String keyword) {
    if (keyword.isEmpty) {
      return pegawaiList;
    } else {
      return pegawaiList
          .where((pegawai) =>
      pegawai.nama.toLowerCase().contains(keyword.toLowerCase()) ||
          pegawai.nobp.toLowerCase().contains(keyword.toLowerCase()) ||
          pegawai.email.toLowerCase().contains(keyword.toLowerCase()) ||
          pegawai.nohp.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
  }

  Future<void> deletePegawai(String id) async {
    var url = Uri.parse(
        "http://192.168.100.238/edukasi_server/deletePegawai.php?id=$id");

    try {
      var response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (decodedResponse['value'] == 1) {
          // Penghapusan berhasil
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pegawai berhasil dihapus')),
          );
          // Lakukan pembaruan UI jika diperlukan
          setState(() {
            pegawaiList!.removeWhere((element) => element.id == id);
            filteredPegawaiList = List.from(pegawaiList!);
          });
        } else {
          // Penghapusan gagal, tampilkan pesan kesalahan
          throw Exception(decodedResponse['message']);
        }
      } else {
        // Tangani kesalahan status HTTP
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani kesalahan lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Data Pegawai')),
              backgroundColor: Colors.cyan,
              actions: [
                TextButton(
                    onPressed: () {}, child: Text('Hi .. ${session.userName}')),
                //logout
                IconButton(
                  onPressed: () {
                    setState(() {
                      session.clearSession();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LatPageLoginApi()),
                              (route) => false);
                    });
                  },
                  icon: Icon(Icons.exit_to_app),
                  tooltip: 'Logout',
                )
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        filteredPegawaiList = pegawaiList
                            ?.where((element) =>
                        element.nama!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                            element.nobp!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.email!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.nohp!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.nobp!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getPegawai(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Datum>?> snapshot) {
                      if (snapshot.hasData) {
                        pegawaiList = snapshot.data;
                        if (filteredPegawaiList == null) {
                          filteredPegawaiList = pegawaiList;
                        }
                        return ListView(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Nama',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'No BP',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Email',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'No. HP',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Tanggal Daftar',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Aksi',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: filteredPegawaiList!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  Datum pegawai =
                                      entry.value; // Deklarasi variabel pegawai
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(pegawai.nama)),
                                      DataCell(Text(pegawai.nobp)),
                                      DataCell(Text(pegawai.email)),
                                      DataCell(Text(pegawai.nohp)),
                                      DataCell(
                                        Text(
                                          pegawai.tanggalInput != null
                                              ? pegawai.tanggalInput.toString()
                                              : '',
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text('Hapus Data'),
                                                    content: Text(
                                                        'Apakah Anda yakin ingin menghapus data ini?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Batal'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Kirim request untuk menghapus data karyawan
                                                          http.post(
                                                            Uri.parse(
                                                                'http://192.168.100.238/edukasi_server/deletePegawai.php'),
                                                            body: {
                                                              'id': entry.value.id
                                                                  .toString()
                                                            }, // Kirim ID karyawan yang akan dihapus
                                                          ).then((response) {
                                                            // Memeriksa respons dari server
                                                            if (response
                                                                .statusCode ==
                                                                200) {
                                                              var jsonResponse =
                                                              json.decode(
                                                                  response
                                                                      .body);
                                                              if (jsonResponse[
                                                              'isSuccess'] ==
                                                                  true) {
                                                                // Jika penghapusan berhasil, hapus data dari daftar
                                                                setState(() {
                                                                  filteredPegawaiList
                                                                      ?.removeAt(
                                                                      entry
                                                                          .key);
                                                                });
                                                              } else {
                                                                // Jika penghapusan gagal, tampilkan pesan kesalahan
                                                                showDialog(
                                                                  context: context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          "Berhasil"),
                                                                      content: Text(
                                                                          "${jsonResponse['message']}"),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator
                                                                                .pushAndRemoveUntil(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => PageListPegawai()),
                                                                                  (route) =>
                                                                              false,
                                                                            );
                                                                          },
                                                                          child: Text(
                                                                              "OK"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            } else {
                                                              // Jika respons server tidak berhasil, tampilkan pesan kesalahan umum
                                                              showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        "Gagal"),
                                                                    content: Text(
                                                                        "Terjadi kesalahan saat mengirim data ke server"),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            "OK"),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          }).catchError((error) {
                                                            // Tangani kesalahan koneksi atau lainnya
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title:
                                                                  Text("Gagal"),
                                                                  content: Text(
                                                                      "Terjadi kesalahan: $error"),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          });
                                                          Navigator.of(context).pop(
                                                              true); // Tutup dialog
                                                        },
                                                        child: Text('Ya'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.delete),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => PageUpdatePegawai(data : filteredPegawaiList![entry.key]),
                                                  ),
                                                ).then((updatedData) {
                                                  if (updatedData != null) {
                                                    setState(() {
                                                      int dataIndex = filteredPegawaiList!.indexWhere((pegawai) => pegawai.id == updatedData.id);
                                                      if (dataIndex != -1) {
                                                        filteredPegawaiList![dataIndex] = updatedData;
                                                      }
                                                    });
                                                  }
                                                });
                                              },
                                              icon: Icon(Icons.edit),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
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
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PageAddPegawai()),
                // );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.cyan,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            ),
        );
    }
}
