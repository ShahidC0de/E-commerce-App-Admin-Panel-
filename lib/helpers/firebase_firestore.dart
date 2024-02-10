// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/models/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<UserModel>> getUsersList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').get();
    return querySnapshot.docs.map((e) => UserModel.fronJson(e.data())).toList();
  }

  Future<List<CategoryModel>> getCategories1() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories1").get();
      List<CategoryModel> categoriesList1 = querySnapshot.docs
          .map((e) => CategoryModel.fronJson(e.data()))
          .toList();

      return categoriesList1;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteUser(String id) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(id).delete();
      return 'successfully deleted';
    } catch (e) {
      return (e.toString());
    }
  }

  Future<String> deleteSingleCategorie(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories1')
          .doc(id)
          .delete();
      return 'successfully deleted';
    } catch (e) {
      return (e.toString());
    }
  }

  Future<void> updateSingleCategorie(CategoryModel categoryModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories1')
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } catch (e) {
      showMessage(e.toString());
    }
  }
}
