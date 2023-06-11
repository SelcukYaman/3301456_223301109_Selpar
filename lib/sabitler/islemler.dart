import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/profil.dart';

void deleteData(String id,BuildContext context) {
  FirebaseFirestore.instance
      .collection('selcukyaman123123')
      .doc(id)
      .delete()
      .then((value) {
    Navigator.push(
      context!,

      MaterialPageRoute(builder: (context1) => profil(),

      ),
    );
    print('Veri silindi');
  }).catchError((error) {
    print('Hata: $error');
  });
}