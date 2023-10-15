import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppNetwork {
  final db = FirebaseFirestore.instance;

  Future get(String collectionName) async {
    try {
      QuerySnapshot res = await db.collection(collectionName).get();
      return res.docs;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
