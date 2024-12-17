import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mimo/features/task/model/category_model.dart';
import 'package:mimo/service/firestore_service.dart';

class CategoryController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController titleController = TextEditingController();
  TextEditingController iconController = TextEditingController();

  List<CategoryModel> categories = [];
  bool isLoading = false;

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      categories = await _firestoreService.getAllCategories();
    } catch (e) {
      log('Error fetching categories: $e');
      categories = [];
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  Future<void> addCategory() async {
    isLoading = true;
    notifyListeners();

    try {
      CategoryModel category = CategoryModel(
          id: "${titleController.text}${DateTime.now()}",
          title: titleController.text,
          icon: iconController.text);
      await _firestoreService.addCategory(category);
      fetchCategories();
    } catch (e) {
      log('Error adding category: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.updateCategory(category);
      int index = categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        categories[index] = category;
      }
    } catch (e) {
      log('Error updating category: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.deleteCategory(id);
      categories.removeWhere((c) => c.id == id);
    } catch (e) {
      log('Error deleting category: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
