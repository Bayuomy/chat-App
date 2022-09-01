import 'package:chatapp/Pages/login_page.dart';
import 'package:chatapp/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../wedgets/CustomTextfiled.dart';
import '../wedgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_page.dart';

class Regester_page extends StatefulWidget {
  Regester_page({Key? key}) : super(key: key);
  static String Id = 'Regester_page';

  @override
  State<Regester_page> createState() => _Regester_pageState();
}

class _Regester_pageState extends State<Regester_page> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: KprimiryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset("assets/images/scholar.png"),
                  Text(
                    'School Chat ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Sign up ',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomTextFild(
                        onChanged: (data) {
                          email = data;
                        },
                        hinttext: ' Email',
                        obscureText: false),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomTextFild(
                        onChanged: (data) {
                          password = data;
                        },
                        hinttext: ' passward',
                        obscureText: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Custom_button(
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          isloading = true;
                          setState(() {});
                          try {
                            await RegesterUser();
                            ShowSnakBar(context, 'succes');
                            Navigator.pushNamed(context, Chat_page.Id,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ShowSnakBar(context, 'weak password');
                            } else if (e.code == 'email-already-in-use') {
                              ShowSnakBar(context, 'email Already exists');
                            }
                          }
                          isloading = false;
                          setState(() {});
                        } else {}
                      },
                      text: 'Regester',
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 65,
                      ),
                      Text(
                        "already have an acount",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: Text(
                          "sign in",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ShowSnakBar(BuildContext context, String Message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(Message)));
  }

  Future<void> RegesterUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
