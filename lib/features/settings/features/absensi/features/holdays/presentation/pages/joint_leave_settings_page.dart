import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_tab_bar.dart';

class JointLeaveSettingsPage extends StatelessWidget {
  const JointLeaveSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusList = [
      "Diperiksa",
      "Diterima",
      "Ditolak",
    ];

    return Scaffold(
      appBar: CustomAppBar(title: "Cuti Bersama"),
      body: DefaultTabController(
        length: statusList.length + 1,
        child: Column(
          children: [
            CustomTabBar(statusList: statusList),
            Expanded(
              child: TabBarView(
                children: [
                  //-----------/ Semua /-----------//
                  ListView(
                    padding: EdgeInsets.all(12),
                    children: [
                      _DataItem(
                        status: 0,
                        statusText: statusList[0],
                        start: DateTime(2026),
                        end: DateTime(2026),
                      ),
                      _DataItem(
                        status: 1,
                        statusText: statusList[1],
                        start: DateTime(2026),
                        end: DateTime(2026),
                      ),
                      _DataItem(
                        status: 2,
                        statusText: statusList[2],
                        start: DateTime(2026),
                        end: DateTime(2026),
                      ),
                    ],
                  ),

                  //-----------/ Status Lain /-----------//
                  ...List.generate(statusList.length, (status) {
                    final statusText = statusList[status];
                    return ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _DataItem(
                          status: status,
                          statusText: statusText,
                          start: DateTime(2026),
                          end: DateTime(2026),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () {
            context.push(AppRoutes.settingsAbsenceAddJointLeave.path);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 12),
              Text("Cuti Bersama"),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  const _DataItem({
    required this.status,
    required this.statusText,
    required this.start,
    required this.end,
  });

  final int status;
  final String statusText;
  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd MMMM yyyy");
    final startString = formatter.format(start);
    final endString = formatter.format(end);

    final backgroundColors = [
      Color(0xFFFFF5CD),
      null,
      Colors.red.withAlpha(40),
    ];
    final foregroundColors = [
      Color(0xFFBE9621),
      null,
      Colors.red,
    ];

    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (status != 1) // Kalau status bukan 'diterima'
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColors[status],
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: foregroundColors[status],
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                SizedBox(height: 16),
                Text(
                  "Tahun Baru Masehi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "$startString - $endString",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            color: Colors.blue.withAlpha(50),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 12),
                Text(
                  "HRD",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
