// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/features/task/controller/task_controller.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:mimo/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

class AddTaskCard extends StatelessWidget {
  const AddTaskCard({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final taskController = Provider.of<TaskController>(context, listen: false);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
        child: Card(
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: taskController.taskController,
                  hint: 'Task',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: whiteColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomText(text: 'Cancel'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () async {
                        await taskController.addTask(categoryId);
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                        text: 'Save',
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
