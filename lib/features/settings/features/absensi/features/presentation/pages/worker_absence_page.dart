import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class WorkerAbsencePage extends StatelessWidget {
  const WorkerAbsencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Daftar Pekerja Harian"),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(AppRoutes.settingsAbsensiPenempatanPekerjaHarian.path);
            },
            child: Card(
              elevation: 1,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    //-----------/ Foto /-----------//
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                    ),

                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //-----------/ Nama /-----------//
                          Text(
                            "Nama Pekerja",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          //-----------/ Jabatan /-----------//
                          SizedBox(height: 4),
                          Text(
                            "Helper",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
