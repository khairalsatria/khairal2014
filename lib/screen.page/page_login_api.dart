import 'package:flutter/material.dart';
import 'package:khairal2014/model/model_login.dart';
import 'package:khairal2014/screen.page/page_list_berita.dart';
import 'package:khairal2014/screen.page/page_register_api.dart';
import 'package:http/http.dart' as http;
import 'package:khairal2014/utils/session_manager.dart';


class PageLoginApi extends StatefulWidget {
  const PageLoginApi({super.key});

  @override
  State<PageLoginApi> createState() => _PageLoginApiState();
}

class _PageLoginApiState extends State<PageLoginApi> {
  //untuk mendapatkan value dari text field
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  //TASK : silahkan hubungan yg page login dengan api
  //kalau berhasil login pindah ke page list berita
  bool isLoading = false;
  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
          Uri.parse('http://192.168.1.15/beritaDb/login.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,

          });

      ModelLogin data = modelLoginFromJson(res.body);
      //cek kondisi respon
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          //untuk simpan sesi
          session.saveSession(data.value ?? 0, data.id ?? "", data.username ?? "");

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          //kondisi berhasil dan pindah ke page login
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageListBerita()),
                  (route) => false);
        });
        //kondisi email sudah ada
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
        //kondisi gagal daftar
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
      }
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }



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
                Center(
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : MaterialButton(
                    minWidth: 150,
                    height: 45,
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        loginAccount();
                      }
                    },
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
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