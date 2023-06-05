import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task01/Services/comom_keys.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Services/string_resorces.dart';

import '../Services/AuthenticationServices.dart';
import '../Ui_Pages/HomePage.dart';

class LoginPageProvider with ChangeNotifier {
  var isloading = false;

  signinOnFirebase(email, passwd, context) async {
    try {
      isloading = true;
      notifyListeners();
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: passwd);
      userid = auth.currentUser?.uid;
      Authentication.keepsession();
      isloading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
      result = null;
      notifyListeners();

      result = login_success;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isloading = false;
      notifyListeners();
      if (e.code == e_code_user_not_found) {
        result = user_not_exist;
        notifyListeners();
      } else if (e.code == e_code_wrong_passwd) {
        result = wrong_passwd;
        notifyListeners();
      }
    } catch (e) {
      result = "$e";
      notifyListeners();
    }
    return result;
  }
}
