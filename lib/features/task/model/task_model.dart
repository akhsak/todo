import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id;
  final String? categoryId;
  final String? task;
  final Timestamp? date;
  final bool? isComplete;

  TaskModel({
    this.id,
    this.categoryId,
    this.task,
    this.date,
    this.isComplete,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'task': task,
      'date': date,
      'isComplete': isComplete,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      categoryId: json['categoryId'],
      isComplete: json['isComplete'],
      task: json['task'],
      date: json['date'] as Timestamp,
    );
  }
}
