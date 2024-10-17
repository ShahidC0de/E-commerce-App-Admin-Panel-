// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/helpers/firebase_storage_helper.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/models/order_model.dart';
import 'package:techtrove_admin/models/product_model.dart';
import 'package:techtrove_admin/models/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<UserModel>> getUsersList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
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

  Future<void> updateUser(UserModel userModel) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .update(userModel.toJson());
    } catch (_) {}
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

  Future<void> updateSingleCategory(CategoryModel categoryModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories1')
          .doc(categoryModel.id)
          .update(
            categoryModel.toJson(),
          );
    } catch (_) {}
  }

  Future<CategoryModel> addSingleCategory(File image, String name) async {
    try {
      DocumentReference reference =
          FirebaseFirestore.instance.collection('categories1').doc();
      String imageUrl = await FirebaseStorageHelper.instance
          .uploadUserImage(reference.id, image);
      CategoryModel addCategory =
          CategoryModel(image: imageUrl, id: reference.id, name: name);
      await reference.set(addCategory.toJson());
      return addCategory;
    } catch (e) {
      // Handle any errors that occur during the addSingleCategory operation
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup('products').get();
    List<ProductModel> productModel =
        querySnapshot.docs.map((e) => ProductModel.fronJson(e.data())).toList();
    return productModel;
  }

  Future<String> deleteSingleProduct(
      String categoryId, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories1')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .delete();

      return 'successfully deleted';
    } catch (e) {
      return (e.toString());
    }
  }

  Future<void> updateSingleProduct(ProductModel productModel) async {
    await FirebaseFirestore.instance
        .collection('categories1')
        .doc(productModel.categoryId)
        .collection('products')
        .doc(productModel.id)
        .update(productModel.toJson());
  }

  Future<ProductModel> addSingleProduct(File image, String name,
      String description, String price, String categoryId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('categories1')
        .doc(categoryId)
        .collection('products')
        .doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    ProductModel addProduct = ProductModel(
      image: imageUrl,
      id: reference.id,
      name: name,
      price: double.parse(price),
      description: description,
      categoryId: categoryId,
      isFavourate: false,
      qty: 1,
    );
    await reference.set(addProduct.toJson());
    return addProduct;
  }

  Future<List<OrderModel>> getCompletedOrders() async {
    QuerySnapshot<Map<String, dynamic>> completedOrders =
        await FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'Delievered')
            .get();
    List<OrderModel> completedOrderList =
        completedOrders.docs.map((e) => OrderModel.fronJson(e.data())).toList();
    return completedOrderList;
  }

  Future<List<OrderModel>> getCanceledOrders() async {
    QuerySnapshot<Map<String, dynamic>> canceledOrders = await FirebaseFirestore
        .instance
        .collection('orders')
        .where('status', isEqualTo: 'Canceled')
        .get();
    List<OrderModel> canceledOrderList =
        canceledOrders.docs.map((e) => OrderModel.fronJson(e.data())).toList();
    return canceledOrderList;
  }

  Future<List<OrderModel>> getPendingOrders() async {
    QuerySnapshot<Map<String, dynamic>> pendingOrders = await FirebaseFirestore
        .instance
        .collection('orders')
        .where('status', isEqualTo: 'pending')
        .get();
    List<OrderModel> pendingOrdersList =
        pendingOrders.docs.map((e) => OrderModel.fronJson(e.data())).toList();
    return pendingOrdersList;
  }

  Future<void> updateOrderStatus(OrderModel orderModel, String update) async {
    await FirebaseFirestore.instance
        .collection('usersOrders')
        .doc(orderModel.userId)
        .collection('orders')
        .doc(orderModel.orderId)
        .update({
      'status': update,
    });
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderModel.orderId)
        .update({
      'status': update,
    });
  }
}
