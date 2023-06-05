import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task01/Services/comom_keys.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Services/string_resorces.dart';
import 'package:task01/Ui_Pages/HomePage.dart';
import 'package:task01/Ui_Pages/Login_Screen.dart';

final storage = new FlutterSecureStorage();
var userid;
var result;

class Authentication {
  static signupOnFirebase(email, password, first, last, context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userid = auth.currentUser?.uid;
      keepsession();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
      firestoreData(
        email,
        password,
        first,
        last,
      );

      print(login_success);
    } on FirebaseAuthException catch (e) {
      print("$e");
    } catch (e) {
      print(local_exception);
    }
  }

  static firestoreData(
    Email,
    Passwd,
    First,
    Last,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    userid = auth.currentUser?.uid;
    String? first = First;
    String? last = Last;
    String? email = Email;
    String? passwd = Passwd;
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection(db_keys).doc(userid).set({
      doc_field_first: first,
      doc_field_last: last,
      doc_field_email: email,
      doc_field_passwd: passwd,
      doc_field_userid: userid
    });
    userid = auth.currentUser?.uid ?? 1;
    keepsession();
  }

  static signout(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    storage.write(key: session_key, value: string_false);
    storage.write(key: session_userid, value: null);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  static keepsession() async {
    await storage.write(key: session_key, value: string_true);
    await storage.write(key: session_userid, value: userid);
  }

  static showdialog(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(logout_btn),
              content: Text(dialog_content),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      signout(context);
                    },
                    child: Text(yes)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(no))
              ],
            ));
  }

  static update(first, last, email) {
    FirebaseFirestore.instance.collection(db_keys).doc(userid).update(
        {doc_field_first: first, doc_field_last: last, doc_field_email: email});
  }
}
