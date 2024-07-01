import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

const secondaryColor = Color(0xFF5593f8);
const primaryColor = Color(0xFF48c9e2);
Color bgColor = const Color.fromARGB(255, 186, 177, 241);
Color textColor = const Color.fromARGB(255, 71, 61, 118);
Color buttonColor = const Color.fromARGB(255, 80, 67, 111);
Color secondaryTextColor = const Color.fromARGB(255, 146, 131, 168);
Color formColor = const Color(0xffF5F6FA);
Color textFormColor = const Color.fromARGB(255, 120, 97, 159);

TextStyle appName = GoogleFonts.audiowide(color: buttonColor);
TextStyle textNormal = GoogleFonts.arimo(color: buttonColor);
TextStyle textNormal2 = GoogleFonts.arimo(color: bgColor);

final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
final DateFormat formatDate = DateFormat('yyyy-MM-dd H:mm');
const tokenStoreName = "access_token";
