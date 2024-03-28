import 'package:flutter/material.dart';

class PageSearchList extends StatefulWidget {
  const PageSearchList({super.key});
  @override
  State<PageSearchList> createState() => _PageSearchListState();
}

class _PageSearchListState extends State<PageSearchList> {
  List<String> listDevice = [
    "iPhone",
    "Samsung",
    "Realme",
    "VIVO",
    "OPPO",
    "SONY",
    "iPad",
    "iWatch",
    "Xiaomi",
    "Infinix",
    "Huawei",
    "Motorola",
    "Nokia",
    "Blackberry",
  ];
  bool isCari = true;
  List<String> filterDevice = [];
  TextEditingController cari = TextEditingController();

  _PageSearchListState() {
    cari.addListener(() {
      if (cari.text.isEmpty) {
        setState(() {
          isCari = true;
          cari.text = "";
        });
      } else {
        setState(() {
          isCari = false;
          cari.text != "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search List"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: cari,
              decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.1)),
            ),
            isCari ? Expanded(
                    child: ListView.builder(
                        itemCount: listDevice.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(listDevice[index]),
                          );
                        }),
                  )
                : CreateFilterList(),
          ],
        ),
      ),
    );
  }

  Widget CreateFilterList() {
    filterDevice = [];
    for (int i = 0; i < listDevice.length; i++) {
      var item = listDevice[i];
      if (item.toLowerCase().contains(cari.text.toLowerCase())) {
        filterDevice.add(item);
      }
    }
    return HasilSearch();
  }

  Widget HasilSearch() {
    return Expanded(
      child: ListView.builder(
          itemCount: filterDevice.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filterDevice[index]),
            );
          }),
    );
  }
}
