import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task01/Provider/homePage_provider.dart';
import 'package:task01/Services/AuthenticationServices.dart';
import 'package:task01/Services/comom_keys.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Services/string_resorces.dart';
import 'package:task01/Ui_Pages/detailPage.dart';

import '../Services/dimesion.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController email = TextEditingController();

  bool loading = false;

  GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    userid = storage.read(key: session_userid);
    HomePageProvider().fatchingdata(firstName, lastName, email);
  }

  @override
  void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(main_page),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: popup_menu_item_0,
                  child: Text(detail_btn),
                ),
                PopupMenuItem<int>(
                  value: popup_menu_item_1,
                  child: Text(logout_btn),
                )
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage()),
                );
              } else {
                Authentication.showdialog(context);
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimenResource.D_10),
        child: SingleChildScrollView(
          child: ChangeNotifierProvider<HomePageProvider>(
            create: (context) => HomePageProvider(),
            child: Center(
              child: Consumer<HomePageProvider>(
                builder: (context, provider, child) {
                  return Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: DimenResource.D_10,
                          ),
                          TextFormField(
                            enabled: provider.isEnable,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return entFnm;
                              } else {
                                return null;
                              }
                            },
                            controller: firstName,
                            obscureText: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                label: Text(l_first),
                                hintText: hint_first,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2)),
                                // ignore: prefer_const_constructors
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red))),
                          ),
                          const SizedBox(
                            height: DimenResource.D_10,
                          ),
                          TextFormField(
                            enabled: provider.isEnable,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return entLnm;
                              } else {
                                return null;
                              }
                            },
                            controller: lastName,
                            obscureText: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                label: Text(l_last),
                                hintText: hint_last,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2)),
                                // ignore: prefer_const_constructors
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red))),
                          ),
                          const SizedBox(
                            height: DimenResource.D_10,
                          ),
                          TextFormField(
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return entVemail;
                              } else if (regex.hasMatch(email.toString())) {
                                return null;
                              } else {
                                return entVemail;
                              }
                            },
                            enabled: provider.isEnable,
                            controller: email,
                            obscureText: false,
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
                          const SizedBox(
                            height: DimenResource.D_10,
                          ),
                          provider.isEnable == false
                              ? ElevatedButton(
                                  onPressed: () {
                                    provider.fieldEnable();
                                  },
                                  child: Text(edit_btn))
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      provider.fieldDisable();
                                      Authentication.update(firstName.text,
                                          lastName.text, email.text);
                                    } else {
                                      return null;
                                    }
                                  },
                                  child: Text(update_btn)),
                        ],
                      ));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
