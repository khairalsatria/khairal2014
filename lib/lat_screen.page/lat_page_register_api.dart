import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khairal2014/lat_screen.page/lat_page_login_api.dart';
import 'package:http/http.dart' as http;
import '../lat_model/model_register.dart';

class LatPageRegisterApi extends StatefulWidget {
  const LatPageRegisterApi({super.key});

  @override
  State<LatPageRegisterApi> createState() => _LatPageRegisterApiState();
}

class _LatPageRegisterApiState extends State<LatPageRegisterApi> {

  //untuk mendapatkan value dari text field
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();

  //validasi form
  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  //proses untuk hit api
  bool isLoading = false;
  Future<ModelRegister?> registerAccount() async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(Uri.parse('http://192.168.100.238/edukasi_server/register.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,
            "fullname": txtFullName.text,
            "email": txtEmail.text,
            "nohp": txtNohp.text,
          }
      );
      ModelRegister data = modelRegisterFromJson(response.body);
      //cek kondisi
      if(data.value == 1){
        //kondisi ketika berhasil register
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );

          //pindah ke page login
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
          => LatPageLoginApi()
          ), (route) => false);
        });
      }else if(data.value == 2){
        //kondisi akun sudah ada
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }else{
        //gagal
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }

    }catch (e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Form  Register'),
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
                  TextFormField(
                    //validasi kosong
                    validator: (val){
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtFullName,
                    decoration: InputDecoration(
                        hintText: 'Input Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    //validasi kosong
                    validator: (val){
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtEmail,
                    decoration: InputDecoration(
                        hintText: 'Input Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
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
                  SizedBox(height: 8,),
                  TextFormField(
                    //validasi kosong
                    validator: (val){
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtNohp,
                    decoration: InputDecoration(
                        hintText: 'Input Nohp',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Center( child: isLoading ? Center(
                    child: CircularProgressIndicator(),
                  ) : MaterialButton(onPressed: (){

                    //cek validasi form ada kosong atau tidak
                    if(keyForm.currentState?.validate() == true){
                      setState(() {
                        registerAccount();
                      });
                    }

                  },
                    child: Text('Register'),
                    color: Colors.green,
                    textColor: Colors.white,
                  )
                  )],
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
                => LatPageLoginApi()
                ));
              },
              child: Text('Anda sudah punya account? Silkan Login'),
            ),
            ),
        );
    }
}
