import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimo/constants/colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.decoration,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.w500,
    this.overflow = false,
    this.size = 15,
  });

  final String text;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final Color? color;
  final FontWeight fontWeight;
  final bool overflow;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: overflow ? 1 : null,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: GoogleFonts.roboto(
        decoration: decoration,
        color: color ?? secondaryColor,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
