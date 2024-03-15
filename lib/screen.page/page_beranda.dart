import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:khairal2014/screen.page/page_bottom_navigation.dart';
import 'package:khairal2014/screen.page/page_navigation_bar.dart';

class PageBeranda extends StatelessWidget {
  const PageBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Projek MI 2C'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'gambar/hwn2.jpg',
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 8,
              ),
              const Image(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
              Text('Program Studi: Manajemen Informatika'),
              Text('Kampus Politeknik Negeri Padang'),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  //tambahkan code toast
                  showToast(
                    'Pindah ke Page Navigation Drawer',
                    context: context,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.bottom,
                    toastHorizontalMargin: 28,
                    fullWidth: true,
                  );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageNavigationBar()
                      ));

                },
                child: Text(
                  'Page Navigation Utama',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      context: context,
                      animation: StyledToastAnimation.slideFromTop,
                      reverseAnimation: StyledToastAnimation.slideToTop,
                      position: StyledToastPosition.top,
                      startOffset: Offset(0.0, -3.0),
                      reverseEndOffset: Offset(0.0, -3.0),
                      duration: Duration(seconds: 4),
                      //Animation duration   animDuration * 2 <= duration
                      animDuration: Duration(seconds: 1),
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.fastOutSlowIn);
                },
                child: Text(
                  'Toast atas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 8,
              ),
              MaterialButton(
                onPressed: () {
                  showToast(
                    'This is normal',
                    context: context,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.bottom,
                    toastHorizontalMargin: 20,
                    fullWidth: true,
                  );
                },
                child: Text(
                  'Explore Here',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  //tambahkan code toast
                  showToast(
                    'Pindah ke Page Navigation Drawer',
                    context: context,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.bottom,
                    toastHorizontalMargin: 28,
                    fullWidth: true,
                  );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageBottomNavigationBar()
                      ));

                },
                child: Text(
                  'Page Navigation Bar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                color: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
