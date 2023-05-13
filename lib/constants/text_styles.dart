import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appBarTitleTS = GoogleFonts.openSans(
  textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
);

TextStyle screenTitleTS = GoogleFonts.openSans(
  textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40,
  ),
);

TextStyle screenSubtitleTS = GoogleFonts.openSans(
  textStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
      // height: 1.5,
      fontSize: 15),
);

TextStyle formInputTS = GoogleFonts.openSans(
  textStyle: const TextStyle(color: Colors.purple, fontSize: 14),
);
