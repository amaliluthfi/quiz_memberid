import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppNetwork {
  final db = FirebaseFirestore.instance;

  Future get({required String collectionName, String? keyword}) async {
    try {
      QuerySnapshot res = await db
          .collection(collectionName)
          .where('name',
              isGreaterThanOrEqualTo:
                  keyword?.replaceFirst(keyword[0], keyword[0].toUpperCase()) ??
                      "")
          .where('name',
              isLessThan:
                  "${keyword?.replaceFirst(keyword[0], keyword[0].toUpperCase()) ?? ""}z")
          .get();
      return res.docs;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
