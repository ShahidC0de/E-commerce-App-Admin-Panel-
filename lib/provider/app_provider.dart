// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/helpers/firebase_firestore.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/models/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _usersList = []; // an empty list of type usermodel class;
  List<CategoryModel> _categoresList = [];
  Future<void> getUsersList() async {
    _usersList = await FirebaseFirestoreHelper.instance.getUsersList();
    // the function is an interface which will call the firebasefirestorehelper to perform the action;
  }

  Future<void> getCatogoryList() async {
    _categoresList = await FirebaseFirestoreHelper.instance.getCategories1();
    // the function is an interface which will call the firebasefirestorehelper to perform the action;
  }

  final bool _isDeletingLoading = false;
  Future<void> deleteTheUser(UserModel userModel) async {
    _isDeletingLoading == true;
    notifyListeners();
    String value =
        await FirebaseFirestoreHelper.instance.deleteUser(userModel.id);
    if (value == 'successfully deleted') {
      _usersList.remove(userModel);
      showMessage('delete successfully');
    }
    _isDeletingLoading == false;

    notifyListeners();
  }

  List<CategoryModel> get getCatogoriesList => _categoresList;
  List<UserModel> get getUserList => _usersList;
  bool get getDeletingLoading => _isDeletingLoading;

  // the purpose of this to use this list anywhere else in the code,withoud accessing the actual _usersList;
  // calling a function is good but actually its getter which fetches the data from the given list;
  Future<void> callBackFunction() async {
    await getUsersList();
    await getCatogoryList();
  }

  void updateUserInfo(int index, UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateUser(userModel);

    _usersList[index] = userModel;
    notifyListeners();
  }

  Future<void> deleteCategoryFromFirebase(CategoryModel categoryModel) async {
    _isDeletingLoading == true;
    notifyListeners();
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleCategorie(categoryModel.id);
    if (value == 'successfully deleted') {
      _categoresList.remove(categoryModel);
      showMessage('delete successfully');
    }
    _isDeletingLoading == false;

    notifyListeners();
  }

  void updateCategoryList(int index, CategoryModel categoryModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleCategory(categoryModel);
    _categoresList[index] = categoryModel;
    notifyListeners();
  }
}
