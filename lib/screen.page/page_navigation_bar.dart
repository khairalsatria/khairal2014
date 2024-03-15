import 'package:flutter/material.dart';
import 'package:khairal2014/screen.page/page_column.dart';
import 'package:khairal2014/screen.page/page_passing_data.dart';

class PageNavigationBar extends StatelessWidget {
  const PageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Navigation Bar'),
      ),

      drawer: SizedBox(
        width: 250,
          child: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text('Khairal Satria'),
                    accountEmail: Text('khairalsatriahaspi@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    radius: 65,
                    child: Icon(
                      Icons.person,
                      color: Colors.green,
                      size: 65,
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => PageRow()));
                  },
                  title: Text(
                    "Row Widget"
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => PageColumn()));
                  },
                  title: Text(
                      "Column Widget"
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => PageColumnRow()));
                  },
                  title: Text(
                      "Row & Column"
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => PageListHorizontal()));
                  },
                  title: Text(
                      "List Horizontal"
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => PagePassingData()));
                  },
                  title: Text(
                      "Passing Data"
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => PageLogin()));
                  },
                  title: Text(
                      "Page Login"
                  ),
                ),
                Divider(),
              ],
            ),
          ),
      ),

      body: Center(
        child: MaterialButton(
          onPressed: (){
            //back ke page sebelumnya
            Navigator.pop(context);
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}

class PageRow extends StatelessWidget {
  const PageRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Row'),
      ),

      //Row, Column, List
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.add_business_sharp),
            Icon(Icons.person),
            Icon(
              Icons.add_call,
              color: Colors.orange,
              size: 64,
            )

          ],
        ),
      ),
    );
  }
}