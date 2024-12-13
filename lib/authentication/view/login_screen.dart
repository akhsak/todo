// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mimo/authentication/controller/auth_controller.dart';
import 'package:mimo/authentication/view/forgot_password.dart';
import 'package:mimo/authentication/view/register_screen.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/constants/enum.dart';
import 'package:mimo/features/home/view/home_screen.dart';
import 'package:mimo/widgets/custom_elevated_button.dart';
import 'package:mimo/widgets/custom_snackbar.dart';
import 'package:mimo/widgets/custom_text.dart';
import 'package:mimo/widgets/custom_text_field.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
                  height: size.height * .1,
                ),
                Center(
                  child: Image.asset(
                    'assets/logo/memo_logo.png',
                    width: size.width * 0.4,
                  ),
                ),
                SizedBox(
                  height: size.height * .1,
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
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      )),
                  child: const CustomText(
                    text: 'Forgot Password?',
                    size: 11,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Consumer<AuthController>(builder: (context, value, child) {
                  return FullWidthElevatedButton(
                      buttonText: "Continue",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final result = await authController.loginUser();
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
