import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';

class RevisionNoticePage extends StatelessWidget {
  const RevisionNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            "assets/images/icon/Frame 52086.svg",
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 48),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  "Data Diri Ditolak",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                Text(
                  "Nama Lengkap, Nama SMK, dan Nama Istri tidak sesuai",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () => context.push(AppRoutes.biodataRevisionForm.path),
          child: Text("Perbaiki Data Diri"),
        ),
      ),
    );
  }
}
