import 'package:flutter/material.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/features/task/controller/category_controller.dart';
import 'package:mimo/features/task/controller/task_controller.dart';
import 'package:mimo/features/task/model/task_model.dart';
import 'package:mimo/features/task/view/task_list.dart';
import 'package:mimo/features/task/view/widgets/add_category_card.dart';
import 'package:mimo/features/task/view/widgets/stask.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) {
        if (categoryController.isLoading) {
          // Shimmer effect for loading
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: (size.width / 2) / (size.height / 4),
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: greyColor,
                        child: Container(
                          height: 20,
                          width: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: greyColor,
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: greyColor,
                        child: Container(
                          height: 20,
                          width: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: (size.width / 2) / (size.height / 4),
          ),
          itemCount: categoryController.categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              // "Add New Category" Card
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.white.withOpacity(.8),
                    builder: (BuildContext context) {
                      return AddCategoryCard(size: size);
                    },
                  );
                },
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, size: 30),
                  ),
                ),
              );
            } else {
              // Individual Category Card
              final category = categoryController.categories[index - 1];
              return Consumer<TaskController>(
                builder: (context, taskController, child) {
                  // Count tasks for this category
                  final taskCount = taskController.tasks
                      .where((task) => task.categoryId == category.id)
                      .length;

                  return GestureDetector(
                    onLongPress: () => showDialog(
                        context: context,
                        barrierColor: Colors.white.withOpacity(.8),
                        builder: (BuildContext context) {
                          return AddCategoryCard(size: size);
                        }),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryTasksScreen(category: category),
                          // EditTask(
                          //   task: category,
                          // models: category,
                          // title: category.title, // Pass title
                          // icon: category.icon, // Pass description
                          // ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: category.icon,
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              text: category.title,
                            ),
                            CustomText(
                              text:
                                  '$taskCount task${taskCount == 1 ? '' : 's'}',
                              size: 13,
                              color: greyColor,
                            ),
                            // Removed Expanded widget here
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 160),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryTasksScreen(
                                              category: category,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
