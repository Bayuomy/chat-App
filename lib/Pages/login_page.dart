import 'package:chatapp/Pages/regester.dart';
import 'package:chatapp/helper/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../wedgets/CustomTextfiled.dart';
import '../wedgets/custom_button.dart';
import 'chat_page.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key? key}) : super(key: key);
  static String Id = 'Loginpage';

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isloding = false;
  String? Passward;
  String? email;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloding,
      child: Scaffold(
        backgroundColor: KprimiryColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset("assets/images/scholar.png"),
                const Text(
                  'School Chat ',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico'),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Sign in ',
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
                        Passward = data;
                      },
                      hinttext: ' passward',
                      obscureText: true),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Custom_button(
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          isloding = true;
                          setState(() {});
                          try {
                            await LoginUser();

                            Navigator.pushNamed(context, Chat_page.Id,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ShowSnakBar(
                                  context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              ShowSnakBar(context,
                                  'Wrong password provided for that user.');
                            }
                          }
                          isloding = false;
                          setState(() {});
                        } else {}
                      },
                      text: 'sign in',
                    )),
                Row(
                  children: [
                    const SizedBox(
                      width: 65,
                    ),
                    const Text(
                      "don't have an acount",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'Regester_page');
                      },
                      child: const Text(
                        "sign up",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ShowSnakBar(BuildContext context, String Message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(Message)));
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: Passward!);
    print(user.user!.displayName);
  }
}
