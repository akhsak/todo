import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mimo/features/task/model/category_model.dart';
import 'package:mimo/features/task/model/task_model.dart';
import 'package:mimo/features/user/model/user_model.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Reference storage = FirebaseStorage.instance.ref();

  // User Management
  Future<void> createUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final user = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      return UserModel.fromJson(user.data()!);
    } catch (e) {
      rethrow;
    }
  }

  // Profile Picture Management
  Future<Reference> updateProfilePic(dynamic imageFile,
      {String? imagePath}) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final profilePicRef = storageRef
          .child('profile_pics/${FirebaseAuth.instance.currentUser!.uid}');

      if (imagePath != null && imagePath.isNotEmpty) {
        // Delete the existing image
        await storageRef.child(imagePath).delete();
      }

      // Upload the new image
      await profilePicRef.putFile(imageFile);

      return profilePicRef;
    } catch (e) {
      throw Exception('Error uploading profile pic: $e');
    }
  }

  // Category Management
  Future<void> addCategory(CategoryModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      log('Error adding category: $e');
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .get();
      return querySnapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching categories: $e');
      return [];
    }
  }

  Future<void> updateCategory(CategoryModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.id)
          .update(data.toJson());
    } catch (e) {
      log('Error updating category: $e');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(id)
          .delete();
    } catch (e) {
      log('Error deleting category: $e');
    }
  }

  // Task Management
  Future<void> addTask(TaskModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.categoryId)
          .collection('tasks')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      log('Error adding task: $e');
      rethrow;
    }
  }

  Future<List<TaskModel>> getAllTasks(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(categoryId)
          .collection('tasks')
          .orderBy('date', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> updateTask(TaskModel data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(data.categoryId)
          .collection('tasks')
          .doc(data.id)
          .update({"isComplete": data.isComplete});
    } catch (e) {
      log('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String categoryId, String id) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('category')
          .doc(categoryId)
          .collection('tasks')
          .doc(id)
          .delete();
    } catch (e) {
      log('Error deleting task: $e');
    }
  }
}
