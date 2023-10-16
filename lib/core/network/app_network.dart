import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppNetwork {
  final db = FirebaseFirestore.instance;

  Future get(
      {required String collectionName, String? keyword, String? filter}) async {
    try {
      QuerySnapshot? res;
      if (filter != null && filter != "" && keyword != null && keyword != "") {
        res = await db
            .collection(collectionName)
            .where(Filter.and(
                Filter('name',
                    isEqualTo: keyword.replaceFirst(
                        keyword[0], keyword[0].toUpperCase())),
                Filter("difficulty", isEqualTo: filter)))
            .get();
      } else if (filter == "" && filter == null) {
        res = await db
            .collection(collectionName)
            .where('name',
                isGreaterThanOrEqualTo:
                    keyword?.replaceFirst(keyword[0], keyword[0].toUpperCase()))
            .where('name',
                isLessThan:
                    "${keyword?.replaceFirst(keyword[0], keyword[0].toUpperCase()) ?? ""}z")
            .get();
      } else {
        res = await db
            .collection(collectionName)
            .where('difficulty', isEqualTo: filter)
            .get();
      }
      return res.docs;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
