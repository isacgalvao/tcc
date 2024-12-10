import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QRCodeAttendancePage extends StatelessWidget {
  const QRCodeAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chamada por QR Code",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Icon(
          Icons.qr_code_2,
          size: 200,
        ),
      ),
    );
  }
}
