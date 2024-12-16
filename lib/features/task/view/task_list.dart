import 'package:flutter/material.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/features/task/controller/task_controller.dart';
import 'package:mimo/features/task/model/category_model.dart';
import 'package:mimo/features/task/model/task_model.dart';
import 'package:mimo/features/task/view/widgets/add_task_card.dart';
import 'package:mimo/utils/get_day_description.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CategoryTasksScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryTasksScreen({super.key, required this.category});

  @override
  State<CategoryTasksScreen> createState() => _CategoryTasksScreenState();
}

class _CategoryTasksScreenState extends State<CategoryTasksScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskController>(context, listen: false)
        .fetchTasks(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Row(
          children: [
            CustomText(text: widget.category.icon),
            const SizedBox(width: 8),
            CustomText(text: widget.category.title),
          ],
        ),
      ),
      body: Consumer<TaskController>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final tasks = value.tasks;
        final groupedTasks = <String, List<TaskModel>>{};

        for (var task in tasks) {
          final dateLabel =
              task.date != null ? getDayDescription(task.date!) : 'No Date';
          if (groupedTasks.containsKey(dateLabel)) {
            groupedTasks[dateLabel]!.add(task);
          } else {
            groupedTasks[dateLabel] = [task];
          }
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: groupedTasks.entries.map((entry) {
              final dateLabel = entry.key;
              final tasksForDate = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomText(
                      text: dateLabel,
                      size: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...tasksForDate
                      .map((task) => ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                value.deleteTask(widget.category.id, task.id!);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            leading: InkWell(
                              onTap: () {
                                value.updateTask(TaskModel(
                                  categoryId: widget.category.id,
                                  id: task.id,
                                  task: task.task,
                                  date: task.date,
                                  isComplete: !task.isComplete!,
                                ));
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: greyColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: task.isComplete!
                                      ? Colors.green
                                      : Colors.white,
                                  child: task.isComplete!
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: whiteColor,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            title: CustomText(
                              text: task.task ?? '',
                              textAlign: TextAlign.start,
                            ),
                          ))
                      .toList(),
                ],
              );
            }).toList(),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddTaskCard(categoryId: ""),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
