import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:fun_files/constant.dart';
import 'package:fun_files/models/user.dart';

class SearchControl extends GetxController {
  final Rx<List<Users>> _searchedUsers = Rx<List<Users>>([]);

  List<Users> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Users> retVal = [];
      for (var elem in query.docs) {
        retVal.add(Users.fromSnap(elem));
      }
      return retVal;
    }));
  }
}