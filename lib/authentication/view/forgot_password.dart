// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mimo/authentication/controller/auth_controller.dart';
import 'package:mimo/authentication/view/register_screen.dart';

import 'package:mimo/constants/colors.dart';
import 'package:mimo/constants/enum.dart';
import 'package:mimo/widgets/custom_elevated_button.dart';
import 'package:mimo/widgets/custom_snackbar.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:mimo/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

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
                      text: 'Forgot Password',
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
                  hint: 'Email',
                  controller: authController.emailController,
                  type: TextFieldType.email,
                ),
                const CustomText(
                  text:
                      "Enter the email address you used to create your account, and we will email you a link to reset your password.",
                  size: 11,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Consumer<AuthController>(builder: (context, value, child) {
                  return FullWidthElevatedButton(
                      buttonText: "Continue",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final result = await authController.forgotPassword();
                          if (result != null) {
                            showCustomSnackBar(
                                context: context,
                                type: SnackBarType.error,
                                content: result);
                          } else {
                            showCustomSnackBar(
                              context: context,
                              type: SnackBarType.success,
                              content:
                                  'An email has been sent to your address for verification. Please check your inbox.',
                            );
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
                        text: "Don't have an account? ",
                        size: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            )),
                        child: const CustomText(
                          text: "Register",
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
