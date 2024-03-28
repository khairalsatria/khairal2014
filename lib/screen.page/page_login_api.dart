import 'package:flutter/material.dart';
import 'package:khairal2014/screen.page/page_register_api.dart';

class PageLoginApi extends StatefulWidget {
  const PageLoginApi({super.key});

  @override
  State<PageLoginApi> createState() => _PageLoginApiState();
}

class _PageLoginApiState extends State<PageLoginApi> {
  //untuk mendapatkan value dari text field
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();


  //validasi form
  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Form  Login'),
      ),

      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtUsername,
                  decoration: InputDecoration(
                      hintText: 'Input Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),


                SizedBox(height: 8,),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtPassword,
                  obscureText: true,//biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),

                SizedBox(height: 15,),
                MaterialButton(onPressed: (){
                  //cara get data dari text form field
                  setState(() {
                    // String username = txtUsername.text;
                    // String pwd = txtPassword.text;
                    //
                    // print('Hasil login: ${username} dan pwd = ${pwd}');
                  });
                },
                  child: Text('Login'),
                  color: Colors.green,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1, color: Colors.green)
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)
            => PageRegisterApi()
            ));
          },
          child: Text('Anda belum punya account? Silkan Register'),
        ),
      ),
    );
  }
}