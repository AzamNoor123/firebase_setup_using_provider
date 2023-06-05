import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task01/Services/comom_keys.dart';
import 'package:task01/Services/string_resorces.dart';

class HomePageProvider with ChangeNotifier {
  bool isEnable = false;
  String? first, last, email;
  Map fireBasedata = {
    doc_field_first: '',
    doc_field_last: '',
    doc_field_email: '',
  };

  fieldEnable() {
    isEnable = true;
    notifyListeners();
  }

  fieldDisable() {
    isEnable = false;
    notifyListeners();
  }

  Future<void> fatchingdata(TextEditingController firstctr,
      TextEditingController lastctr, TextEditingController emailctr) async {
    bool loading = true;
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? userid = auth.currentUser?.uid;

    await firestore
        .collection(db_keys)
        .doc(userid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        firstctr.text = documentSnapshot[doc_field_first];
        lastctr.text = documentSnapshot[doc_field_last];
        emailctr.text = documentSnapshot[doc_field_email];
        loading = false;
      } else {
        loading = false;
      }
    });
  }
}
