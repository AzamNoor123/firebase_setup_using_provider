import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task01/Services/constant_resources.dart';
import 'package:task01/Services/string_resorces.dart';

import '../Services/dimesion.dart';

class DetailPage extends StatelessWidget {
  const DetailPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(detail_page),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(db_keys)
                .where(db_user_id,
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(error_msg);
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                          Text(
                            'First Name:${snapshot.data!.docs[index]['First']}',
                            style:
                                const TextStyle(fontSize: DimenResource.D_20),
                          ),
                          const SizedBox(height: DimenResource.D_20),
                          Text(
                            "LAst Name:${snapshot.data!.docs[index]['Last']}",
                            style:
                                const TextStyle(fontSize: DimenResource.D_20),
                          ),
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                          Text(
                            "Email:${snapshot.data!.docs[index]["Email"]}",
                            style:
                                const TextStyle(fontSize: DimenResource.D_20),
                          ),
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                        ],
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
