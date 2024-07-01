// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/helpers/firebase_firestore.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/models/order_model.dart';
import 'package:techtrove_admin/models/product_model.dart';
import 'package:techtrove_admin/models/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _usersList = []; // an empty list of type usermodel class;
  List<CategoryModel> _categoresList = [];
  List<ProductModel> _productModelList = [];
  List<OrderModel> _completedOrderList = [];
  List<OrderModel> _canceledOrderList = [];
  List<OrderModel> _pendingOrderList = [];

  Future<void> getPendingOrders() async {
    _pendingOrderList =
        await FirebaseFirestoreHelper.instance.getPendingOrders();
  }

  double _totalEarning = 0.0;
  Future<void> getCanceledOrders() async {
    _canceledOrderList =
        await FirebaseFirestoreHelper.instance.getCanceledOrders();

    // the function is an interface which will call the firebasefirestorehelper to perform the action;
  }

  Future<void> getCompletedOrders() async {
    _completedOrderList =
        await FirebaseFirestoreHelper.instance.getCompletedOrders();
    for (var element in _completedOrderList) {
      _totalEarning += element.totalPrice;
    }
    // the function is an interface which will call the firebasefirestorehelper to perform the action;
  }

  Future<void> getUsersList() async {
    _usersList = await FirebaseFirestoreHelper.instance.getUsersList();
    // the function is an interface which will call the firebasefirestorehelper to perform the action;
  }

  Future<void> getCatogoryList() async {
    _categoresList = await FirebaseFirestoreHelper.instance.getCategories1();
    // the function is an interface which will call the firebasefirestorehelper to perform the action;
  }

  Future<void> getProducts() async {
    _productModelList = await FirebaseFirestoreHelper.instance.getProducts();
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
  List<ProductModel> get getProductList => _productModelList;
  List<OrderModel> get getComPletedOrdErs => _completedOrderList;
  double get getTotalEarning => _totalEarning;
  bool get getDeletingLoading => _isDeletingLoading;
  List<OrderModel> get getCancelOrders => _canceledOrderList;
  List<OrderModel> get getPendOrders => _pendingOrderList;
  // the purpose of this to use this list anywhere else in the code,withoud accessing the actual _usersList;
  // calling a function is good but actually its getter which fetches the data from the given list;
  Future<void> callBackFunction() async {
    await getUsersList();
    await getCatogoryList();
    await getProducts();
    await getCompletedOrders();
    await getCanceledOrders();
    await getPendingOrders();
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

  void addCategoryModel(File image, String name) async {
    try {
      CategoryModel categoryModel =
          await FirebaseFirestoreHelper.instance.addSingleCategory(image, name);
      print('calling addsingleCategory in FirebaseFirestoreHelper');
      _categoresList.add(categoryModel);
      print('adding it to list');
      notifyListeners();
      print('notifying listeners');
    } catch (e) {
      // Handle any errors that occur during the addCategoryModel operation
      print('Error adding category model: $e');
    }
  }

  Future<void> deleteProductFromFirebase(ProductModel productModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleProduct(productModel.categoryId, productModel.id);
    if (value == 'successfully deleted') {
      _productModelList.remove(productModel);
      showMessage('successfully deleted');
    }
    notifyListeners();
  }

  Future<void> updateSingleProductToFirebase(
      int index, ProductModel productModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleProduct(productModel);
    _productModelList[index] = productModel;
    notifyListeners();
  }

  void addProduct(
    File image,
    String name,
    String description,
    String price,
    String categoryId,
  ) async {
    ProductModel productModel = await FirebaseFirestoreHelper.instance
        .addSingleProduct(image, name, description, price, categoryId);
    _productModelList.add(productModel);
    notifyListeners();
  }

  Future<void> updateUserOrder(OrderModel orderModel, String update) async {
    await FirebaseFirestoreHelper.instance
        .updateOrderStatus(orderModel, update);
  }
}
