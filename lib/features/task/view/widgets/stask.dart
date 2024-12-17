// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:mimo/features/task/controller/category_controller.dart';
// import 'package:mimo/features/task/controller/task_controller.dart';
// import 'package:mimo/features/task/model/category_model.dart';
// import 'package:mimo/widgets/custom_text.dart';
// import 'package:mimo/widgets/custom_text_field.dart';
// import 'package:mimo/features/task/model/task_model.dart';
// import 'package:provider/provider.dart';

// class EditTask extends StatefulWidget {
//   final CategoryModel task; // Pass the task to be edited

//   const EditTask({super.key, required this.task});

//   @override
//   State<EditTask> createState() => _EditTaskState();
// }

// class _EditTaskState extends State<EditTask> {
//   late TextEditingController taskController;
//   late TextEditingController titleController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers with current task data
//     taskController =
//         TextEditingController(text: widget.task.icon); // Task title
//     titleController =
//         TextEditingController(text: widget.task.title); // Task description
//   }

//   @override
//   void dispose() {
//     taskController.dispose();
//     titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CategoryController>(
//       builder: (context, taskControllerProvider, child) {
//         return Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.12),
//             child: Card(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Task title field (editable)
//                     CustomTextField(
//                       controller: taskController,
//                       hint: 'Task Title',
//                     ),
//                     const SizedBox(height: 10),
//                     // Task details field (editable)
//                     CustomTextField(
//                       controller: titleController,
//                       hint: 'Task Description',
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Cancel button
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const CustomText(text: 'Cancel'),
//                         ),
//                         const SizedBox(width: 20),
//                         // Save button
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue),
//                           onPressed: () async {
//                             if (taskController.text.trim().isEmpty ||
//                                 titleController.text.trim().isEmpty) {
//                               log('Task and description cannot be empty');
//                               return;
//                             }

//                             // Use the copyWith method to create an updated task
//                             CategoryModel updatedTask = widget.task.copyWith(
//                               icon:
//                                   taskController.text, // Update the task title
//                               title: titleController
//                                   .text, // Update the description
//                             );

//                             // Call updateTask method from TaskController to update Firestore
//                             await taskControllerProvider
//                                 .updateCategory(updatedTask);

//                             // Go back after saving the task
//                             Navigator.pop(context);
//                           },
//                           child: const CustomText(
//                             text: 'save',
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:mimo/features/task/model/category_model.dart';
// import 'package:mimo/widgets/custom_text.dart';
// import 'package:mimo/widgets/custom_text_field.dart';

// class EditTask extends StatefulWidget {
//   final String? title; // Task title
//   final String? icon; // Task description
//   final CategoryModel models;

//   const EditTask({super.key, this.title, this.icon, required this.models});

//   @override
//   State<EditTask> createState() => _EditTaskState();
// }

// class _EditTaskState extends State<EditTask> {
//   late TextEditingController titleController;
//   late TextEditingController descriptionController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers with passed data
//     titleController = TextEditingController(text: widget.title);
//     descriptionController = TextEditingController(text: widget.icon);
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width * 0.12),
//         child: Card(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Task title field (editable)
//                 CustomTextField(
//                   controller: titleController,
//                   hint: 'Task Title',
//                 ),
//                 const SizedBox(height: 10),
//                 // Task description field (editable)
//                 CustomTextField(
//                   controller: descriptionController,
//                   hint: 'Task Description',
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Cancel button
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const CustomText(text: 'Cancel'),
//                     ),
//                     const SizedBox(width: 20),
//                     // Save button
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue),
//                       onPressed: () {
//                         // Just a placeholder for saving action
//                         Navigator.pop(context);
//                       },
//                       child: const CustomText(
//                         text: 'Save',
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
