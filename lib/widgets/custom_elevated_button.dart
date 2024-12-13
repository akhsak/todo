import 'package:flutter/material.dart';
import 'package:mimo/constants/colors.dart';
import 'package:mimo/widgets/custom_text.dart';


class FullWidthElevatedButton extends StatelessWidget {
  const FullWidthElevatedButton({
    super.key,
    required this.buttonText,
    this.child,
    this.textColor = Colors.white,
    this.backgroundColor = primaryColor,
    required this.onPressed,
  });

  final String buttonText;
  final Color textColor;
  final Widget? child;
  final Color backgroundColor;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .075,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * .01)))),
              backgroundColor: WidgetStatePropertyAll(backgroundColor)),
          onPressed: onPressed,
          child: child ??
              CustomText(
                text: buttonText,
                color: textColor,
              )),
    );
  }
}
