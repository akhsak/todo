import 'dart:developer';
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
    notifyListeners();
    try {
      tasks = await _firestoreService.getAllTasks(categoryId);
      log('Fetched tasks for categoryId $categoryId: ${tasks.length}');
    } catch (e) {
      log('Error fetching tasks: $e');
      tasks = [];
      //log(.where((x) => x == true).length);
    }
    isLoading = false;
    log(isLoading.toString());
    notifyListeners();
  }

  Future<void> addTask(String categoryId) async {
    try {
      if (taskController.text.trim().isEmpty) {
        log('Task cannot be empty');
        return;
      }
      await _firestoreService.addTask(TaskModel(
        isComplete: false,
        id: "${taskController.text}${DateTime.now()}",
        categoryId: categoryId,
        task: taskController.text,
        date: Timestamp.now(),
      ));
      fetchTasks(categoryId);
    } catch (e) {
      log('Error adding task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _firestoreService.updateTask(task);
      int index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
        notifyListeners();
      }
    } catch (e) {
      log('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String categoryId, String id) async {
    try {
      await _firestoreService.deleteTask(categoryId, id);
      fetchTasks(categoryId);
    } catch (e) {
      log('Error deleting task: $e');
    }
  }

  //  Future <void> index()
// {
//     $tasks = Task::All();
//     $completed = $tasks->where('completed', 100);
//     //I dunno how...
//     $inprogress = ...;
//     return view('pages.projects', compact('projects', 'tasks', 'completed', 'inprogress'));
// } 
}
