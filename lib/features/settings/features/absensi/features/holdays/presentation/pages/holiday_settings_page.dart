import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/settings/features/absensi/features/holdays/domain/entities/holiday_entity.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';

class HolidaySettingsPage extends StatelessWidget {
  const HolidaySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final holidays = [
      HolidayEntity(
        id: 1,
        title: "Tahun Baru Masehi",
        date: DateTime(2026),
      ),
      HolidayEntity(
        id: 2,
        title: "Tahun Baru Masehi",
        date: DateTime(2026),
      ),
      HolidayEntity(
        id: 3,
        title: "Tahun Baru Masehi",
        date: DateTime(2026),
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(title: "Hari Libur & Cuti Bersama"),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: holidays.length,
        itemBuilder: (context, index) {
          final holiday = holidays[index];
          final dateString = DateFormat("dd MMMM yyyy").format(holiday.date);

          return Card(
            elevation: 2,
            shadowColor: Colors.black54,
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holiday.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    dateString,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () {
            context.push(AppRoutes.settingsAbsenceJointLeave.path);
          },
          child: Text("Ajukan Cuti Bersama"),
        ),
      ),
    );
  }
}
