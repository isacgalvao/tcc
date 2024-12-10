import 'package:flutter/material.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

failSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
    snackPosition: SnackPosition.TOP,
    backgroundColor: HexColor("#FF5C5C"),
    icon: const Icon(Icons.cancel, color: Colors.white),
    shouldIconPulse: true,
    colorText: Colors.white,
  );
}

successSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
    snackPosition: SnackPosition.TOP,
    backgroundColor: HexColor("#4E74F9").withOpacity(1),
    icon: const Icon(Icons.check, color: Colors.white),
    shouldIconPulse: true,
    colorText: Colors.white,
  );
}

attentionSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
    snackPosition: SnackPosition.TOP,
    backgroundColor: HexColor("#FFC700"),
    icon: const Icon(Icons.warning, color: Colors.white),
    shouldIconPulse: true,
    colorText: Colors.white,
  );
}