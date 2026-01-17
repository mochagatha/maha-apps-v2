import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maha_apps_v2/widgets/colors.dart';

///Alert default(alert ya atau tidak mengenaik aksi yang akan dijalankan) X
class AlertShowGagal extends StatelessWidget {
  const AlertShowGagal({
    required this.onPressed,
    required this.widget,
    this.iconGagal = "assets/images/icon/done.png",
    this.berhasil = "Berhasil!",
    super.key,
  });
  final Function()? onPressed;
  final Text widget;
  final String iconGagal;
  final String berhasil;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              berhasil,
              style: GoogleFonts.poppins(
                fontSize: 16, // Responsive font size
                fontWeight: FontWeight.w600,
                color: Color(0xff202020),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(iconGagal)),
              ),
            ),
            const SizedBox(height: 20),
            widget,
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        'Oke',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
