import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0XFF5356FF);
Color secondaryColor = const Color(0XFF5BBCFF);
Color whiteColor = const Color(0xffF1F7F6);
Color blackColor = const Color(0xff14193F);
Color secondaryBlackColor = const Color(0xff18212f);
Color greyColor = const Color(0xffA4A8AE);

Color lightBackgroundColor = const Color(0xffF6F8FB);
Color lightGreyColor = const Color(0xffF6F7FB);

TextStyle blackTextStyle = GoogleFonts.poppins(color: blackColor);
TextStyle whiteTextStyle = GoogleFonts.poppins(color: whiteColor);
TextStyle greyTextStyle = GoogleFonts.poppins(color: greyColor);


TextStyle primaryTextStyle =
    GoogleFonts.poppins(color: primaryColor);
TextStyle secondaryTextStyle =
    GoogleFonts.poppins(color: secondaryColor);

// TextStyle blackTextStyleTitle = GoogleFonts.poppins(color: blackColor);
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;