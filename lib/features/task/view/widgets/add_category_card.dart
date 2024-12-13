// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/features/task/controller/category_controller.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:mimo/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

class AddCategoryCard extends StatelessWidget {
  const AddCategoryCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final categoryController =
        Provider.of<CategoryController>(context, listen: false);
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
                SizedBox(
                  height: 70,
                  child: CustomTextField(
                    controller: categoryController.iconController,
                    hint: '🏠',
                  ),
                ),
                CustomTextField(
                  controller: categoryController.titleController,
                  hint: 'Title',
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
                        await categoryController.addCategory();
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
