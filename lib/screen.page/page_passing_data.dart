import 'package:flutter/material.dart';
import 'package:khairal2014/screen.page/page_login_berhasil.dart';

class PagePassingData extends StatelessWidget {
  const PagePassingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Passing Data'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text('Judul Berita ke ${index}'),
              subtitle: Text('Ini sub judul berita ke ${index}'),
              onTap: (){
                //ke page detail
                Navigator.push(context, MaterialPageRoute(builder: (context) => PageGetData(index)));

              },
            ),
          );
        }
      ),
    );
  }
}

class PageGetData extends StatelessWidget {
  final int index;
  const PageGetData(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Page Get Data'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Ini adalah judul berita ke ${index}'),
            Text('Ini adalah sub judul berita ke ${index}'),
          ],
        ),
      ),
    );
  }
}

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

  //umendapatkan value dari text field
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Page Login'),
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: txtUsername,
              decoration: InputDecoration(
                hintText: 'Input Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Input Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 15,),
            MaterialButton(onPressed: (){
              setState(() {
                String username = txtUsername.text;
                String pwd = txtPassword.text;

                print('Hasil login: ${username} dan pwd = ${pwd}');

                if (txtUsername.text == 'admin' && txtPassword.text == '123456') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageLoginBerhasil()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Password atau Username Salah"),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }

              });

            },
              child: Text('Login'),
              color: Colors.green,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}


