// ignore_for_file: empty_catches, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mimo/features/task/model/task_model.dart';
import 'package:mimo/service/firestore_service.dart';

class TaskController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController taskController = TextEditingController();
  List<TaskModel> tasks = [];
  bool isLoading = false;

  Future<void> fetchTasks(String categoryId) async {
    isLoading = true;
    try {
      tasks = await _firestoreService.getAllTasks(categoryId);
      // ignore: empty_catches
    } catch (e) {}
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(String categoryId) async {
    try {
      await _firestoreService.addTask(TaskModel(
          isComplete: false,
          id: "${taskController.text}${DateTime.now()}",
          categoryId: categoryId,
          task: taskController.text,
          date: Timestamp.now()));
      fetchTasks(categoryId);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _firestoreService.updateTask(task);
      int index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
        notifyListeners();
      }
    } catch (e) {}
  }

  Future<void> deleteTask(String categoryId, String id) async {
    try {
      await _firestoreService.deleteTask(categoryId, id);
      fetchTasks(categoryId);
      notifyListeners();
    } catch (e) {}
  }
}
