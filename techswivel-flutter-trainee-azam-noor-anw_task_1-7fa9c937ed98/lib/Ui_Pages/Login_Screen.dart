import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task01/Provider/login_provider.dart';
import 'package:task01/Services/AuthenticationServices.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Services/string_resorces.dart';
import 'package:task01/Ui_Pages/SignupScreen.dart';

import '../Services/dimesion.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController emailctr = TextEditingController();

  TextEditingController passwdctr = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailctr.dispose();
    passwdctr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(login_page),
      ),
      body: ChangeNotifierProvider<LoginPageProvider>(
        create: (context) => LoginPageProvider(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(DimenResource.D_20),
            child: Column(
              children: [
                Text(
                  login_credential,
                  style: const TextStyle(
                    fontSize: DimenResource.D_20,
                  ),
                ),
                Center(
                  child: Consumer<LoginPageProvider>(
                    builder: (context, loginProvider, child) => Form(
                        key: formkey,
                        child: Column(
                          children: [
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
                              controller: emailctr,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  label: Text(l_email),
                                  hintText: hint_email,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          DimenResource.D_10),
                                      borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: DimenResource.D_2)),
                                  // ignore: prefer_const_constructors
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          DimenResource.D_10),
                                      borderSide:
                                          const BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(
                              height: DimenResource.D_10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.length < passwd_length) {
                                  return passwdValid;
                                } else {
                                  return null;
                                }
                              },
                              controller: passwdctr,
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  label: Text(l_passwd),
                                  hintText: hint_passwd,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          DimenResource.D_10),
                                      borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: DimenResource.D_2)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          DimenResource.D_10),
                                      borderSide:
                                          const BorderSide(color: Colors.red))),
                            ),
                            ElevatedButton(
                                child: Text(login_btn),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    loginProvider.signinOnFirebase(
                                        emailctr.text, passwdctr.text, context);
                                  } else {}
                                }),
                            loginProvider.isloading == true
                                ? const CircularProgressIndicator()
                                : Text(
                                    result ?? '',
                                    style: const TextStyle(
                                color: Colors.red,
                                fontSize: DimenResource.D_15,
                              ),
                            ),
                            const SizedBox(
                              height: DimenResource.D_30,
                            ),
                            Text(newuser),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()),
                                  );
                                },
                                child: Text(signup_btn,
                                    style: const TextStyle(
                                        fontSize: DimenResource.D_15,
                                        color: Colors.blue))),
                            ElevatedButton(
                                onPressed: () {
                                  FirebaseMessaging.instance
                                      .getToken()
                                      .then((value) {
                                    print('token is $value');
                                  });
                                },
                                child: const Text('token'))
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
