import 'package:flutter/material.dart';
import 'package:khairal2014/lat_screen.page/lat_page_register_api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LatPageRegisterApi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white38,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('gambar/logo_news.png',
                  fit: BoxFit.contain,
                  height: 150,
                  width: 150,),


                Text('',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,)
                )
              ]
          )
      ),
    );
  }
}
