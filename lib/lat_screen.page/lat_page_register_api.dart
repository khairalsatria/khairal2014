import 'package:khairal2014/lat_model/model_register.dart';
import 'package:khairal2014/lat_screen.page/lat_page_login_api.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/model_register.dart';

class LatPageRegisterApi extends StatefulWidget {
  const LatPageRegisterApi({Key? key}) : super(key: key);

  @override
  State<LatPageRegisterApi> createState() => _LatPageRegisterApiState();
}

class _LatPageRegisterApiState extends State<LatPageRegisterApi> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtFullname = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response = await http.post(
        Uri.parse("http://192.168.1.29/edukasi/register.php"),
        body: {
          "fullname": txtFullname.text,
          "username": txtUsername.text,
          "password": txtPassword.text,
          "email": txtEmail.text,
        },
      );
      ModelRegister data = modelRegisterFromJson(response.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LatPageLoginApi()),
                (route) => false,
          );
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtFullname,
                    decoration: InputDecoration(
                      hintText: 'Input Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtUsername,
                    decoration: InputDecoration(
                      hintText: 'Input Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Input Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong " : null;
                    },
                    controller: txtEmail,
                    decoration: InputDecoration(
                      hintText: 'Input Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(height: 15,),
                  Center(
                    child: isLoading ? Center(
                      child: CircularProgressIndicator(),
                    ) : MaterialButton(
                      onPressed: () {
                        if (keyForm.currentState?.validate() == true) {
                          setState(() {
                            registerAccount();
                          });
                        }
                      },
                      child: Text('Register'),
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                  ),
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
                side: BorderSide(width: 1, color: Colors.green),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LatPageLoginApi()),
                );
              },
              child: Text('Anda sudah punya account? Silakan Login'),
            ),
            ),
        );
    }
}
