import 'package:flutter/material.dart';
import 'package:task01/Services/AuthenticationServices.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Services/string_resorces.dart';

import '../Services/dimesion.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  GlobalKey<FormState> formkey2 = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    passwd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(signup_page),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Form(
              key: formkey2,
              child: Column(
                children: [
                  const SizedBox(
                    height: DimenResource.D_10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return entFnm;
                      } else {
                        return null;
                      }
                    },
                    controller: firstName,
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        label: Text(l_first),
                        hintText: hint_first,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: DimenResource.D_2)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.black)),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: DimenResource.D_10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return hint_last;
                      } else {
                        return null;
                      }
                    },
                    controller: lastName,
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        label: Text(l_last),
                        hintText: hint_last,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: DimenResource.D_2)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.black)),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: DimenResource.D_10,
                  ),
                  TextFormField(
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return hint_email;
                      } else if (regex.hasMatch(email.toString())) {
                        return null;
                      } else {
                        return entVemail;
                      }
                    },
                    controller: email,
                    obscureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        label: Text(l_email),
                        hintText: hint_email,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: DimenResource.D_2)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.black)),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: DimenResource.D_10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length < passwd_length) {
                        return passwdValid;
                      } else {
                        return null;
                      }
                    },
                    controller: passwd,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        label: Text(l_passwd),
                        hintText: hint_passwd,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: DimenResource.D_2)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.black)),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(DimenResource.D_10),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formkey2.currentState!.validate()) {
                          Authentication.signupOnFirebase(email.text, passwd.text,
                              firstName.text, lastName.text, context);
                          Authentication.firestoreData(firstName.text,
                              lastName.text, email.text, passwd.text);
                        } else {
                          return result;
                        }
                      },
                      child: Text(signup_btn)),
                ],
              ),
            )),
      ),
    );
  }
}
