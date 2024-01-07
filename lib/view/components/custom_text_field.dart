import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? kbType;
  final String labelText;
  final TextEditingController controller;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final String? Function(String?)? valid;
  final bool isPasswordField;
  final bool? enabled;
  final AutovalidateMode?  autoValidateMode;
  final bool passShow;
  const CustomTextField(
      {Key? key,
      required this.kbType,
      required this.labelText,
      required this.isPasswordField,
      this.enabled,
      required this.passShow,
      this.onPressed,
      this.onChanged,
      this.autoValidateMode,
      required this.controller,
        required this.valid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onChanged: onChanged,
      autovalidateMode: autoValidateMode,
      textDirection: TextDirection.rtl,
      validator: valid,
      controller: controller,
      style: GoogleFonts.cairo(color: const Color(0xff3A3B6B), fontSize: 16),
      keyboardType: kbType,
      // onChanged: onChanged,
      cursorColor: const Color(0xff3A3B6B),
      decoration: InputDecoration(
        // prefixIconColor: Colors.blue,
        errorStyle:
            GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w500),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        fillColor: const Color(0xffF6F6F6),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xff3A3B6B),
          ),
        ),
        disabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xff3A3B6B),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xff3A3B6B),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: onPressed,
                icon: passShow
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off_outlined),
                color: const Color(0xff3A3B6B),
              )
            : const Text(""),
        floatingLabelStyle: GoogleFonts.cairo(
            color: const Color(0xff3A3B6B),
            fontSize: 21,
            fontWeight: FontWeight.w500),
        labelText: labelText,
        labelStyle: GoogleFonts.cairo(
            color: const Color(0xff3A3B6B),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      obscureText: isPasswordField ? passShow : false,
    );
  }
}
