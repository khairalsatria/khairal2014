import 'package:flutter/material.dart';
import 'package:khairal2014/lat_screen.page/lat_edit_profile.dart';
import 'package:khairal2014/utils/lat_session_manager.dart';

class PageProfileUser extends StatefulWidget {
  const PageProfileUser({super.key});

  @override
  State<PageProfileUser> createState() => _PageProfileUserState();
}

class _PageProfileUserState extends State<PageProfileUser> {
  String? userName, name, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSession();
  }

  //untuk mendapatkan sesi
  Future getDataSession() async{
    await Future.delayed(const Duration(seconds: 5),(){
      session.getSession().then((value){
        print('Data sesi ..'+ value.toString());
        userName = session.userName;
        name = session.Nama;
        email = session.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                    radius: 55,
                    child: Icon(
                      Icons.person,
                      color: Colors.green,
                      size: 65,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('${session.Nama}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                SizedBox(
                  height: 10,
                ),
                Text('Username : ${session.userName}'),
                Text('Email : ${session.email}'),
                Text('No HP : ${session.nohp}'),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.blueGrey)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageEditProfile()));
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}