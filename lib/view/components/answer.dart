import 'package:f_a/controllers/quiz_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Answer extends StatelessWidget {
  const Answer({
    Key? key,
    required this.size,
    required this.text,
    required this.isCorrect,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final String text;
  final int isCorrect;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    QuizController controller = Get.find();
    return InkWell(

      onTap: onTap,
      child: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: controller.getAnswerColor(index, isCorrect),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 4)
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.cairo(fontSize: 20.sp, color: Color(0xff3A3B6B)),
          ),
        ),
      ),
    );
  }
}