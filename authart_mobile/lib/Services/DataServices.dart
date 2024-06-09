import 'package:cloud_firestore/cloud_firestore.dart';

class DataServices {
  Future queryData(String query) async {
    return FirebaseFirestore.instance.collection('Artists')
        .where('name', isGreaterThanOrEqualTo: query).get();
  }
}