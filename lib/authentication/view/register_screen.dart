// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mimo/authentication/controller/auth_controller.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/constants/enum.dart';
import 'package:mimo/features/home/view/home_screen.dart';
import 'package:mimo/widgets/custom_elevated_button.dart';
import 'package:mimo/widgets/custom_snackbar.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:mimo/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .18,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    const CustomText(
                      text: 'Create an Account',
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    const SizedBox()
                  ],
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                CustomTextField(
                  hint: 'Full Name',
                  type: TextFieldType.name,
                  controller: authController.fullNameController,
                ),
                CustomTextField(
                  controller: authController.emailController,
                  hint: 'Email',
                  type: TextFieldType.email,
                ),
                CustomTextField(
                  controller: authController.passwordController,
                  type: TextFieldType.password,
                  hint: 'Password',
                ),
                CustomTextField(
                  controller: authController.confirmPasswordController,
                  type: TextFieldType.confirmPassword,
                  hint: 'Confirm Password',
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Consumer<AuthController>(builder: (context, value, child) {
                  return FullWidthElevatedButton(
                      buttonText: "Continue",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final result = await authController.registerUser();
                          if (result != null) {
                            showCustomSnackBar(
                                context: context,
                                type: SnackBarType.error,
                                content: result);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          }
                        }
                      },
                      child: value.isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: whiteColor,
                                ),
                              ),
                            )
                          : null);
                }),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Already have an account? ",
                        size: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CustomText(
                          text: "Log In ",
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          size: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
