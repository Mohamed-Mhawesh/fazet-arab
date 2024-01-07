import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/create_account_controller.dart';

class CountryPicker extends StatelessWidget {
  final String countryName;
  final void Function(String)? onCountryChanged;
  final bool isChoseCountry;

  const CountryPicker(
      {Key? key, required this.countryName, required this.onCountryChanged, required this.isChoseCountry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

      return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color:isChoseCountry?
               const Color(0xff3A3B6B):Colors.red),
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xffF6F6F6)),
            child: CSCPicker(
              dropdownHeadingStyle: GoogleFonts.cairo(
                  color: const Color(0xff3A3B6B),
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w500),
              dropdownItemStyle: GoogleFonts.cairo(
                  color: const Color(0xff3A3B6B),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
              selectedItemStyle: GoogleFonts.cairo(
                  color: const Color(0xff3A3B6B),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
              dropdownDecoration: const BoxDecoration(),
              onCountryChanged: onCountryChanged,
              countrySearchPlaceholder: "ابحث",
              countryDropdownLabel: countryName,
              showCities: false,
              showStates: false,
            ),
          ),
          Visibility(
            visible: !isChoseCountry,
            child: Text("يرجى اختيار البلد التي تسكن بها",style:
            GoogleFonts.cairo(color: Colors.red),),
          )
        ],
      );

  }
}
