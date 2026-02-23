import 'package:flutter/material.dart';
import 'package:maha_apps_v2/features/settings/features/absensi/features/work_hour_placement/domain/entities/placement_entity.dart';
import 'package:maha_apps_v2/features/settings/features/absensi/features/work_hour_placement/domain/entities/work_hour_entity.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_search_dropdown.dart';

class WorkHourPlacementWorkerPage extends StatefulWidget {
  const WorkHourPlacementWorkerPage({super.key});

  @override
  State<WorkHourPlacementWorkerPage> createState() =>
      _WorkHourPlacementWorkerPageState();
}

class _WorkHourPlacementWorkerPageState
    extends State<WorkHourPlacementWorkerPage> {
  PlacementEntity? _selectedPlacement;
  WorkHourEntity? _selectedWorkHour;

  // TODO: replace dummy data
  final _dummyPlacements = [
    PlacementEntity(
      id: 1,
      name: "Cabang 1",
    ),
    PlacementEntity(
      id: 2,
      name: "Cabang 2",
    ),
    PlacementEntity(
      id: 3,
      name: "Cabang 3",
    ),
  ];

  final _dummyWorkHours = [
    WorkHourEntity(
      id: 1,
      code: "JK01",
      name: "Senin",
      startClockIn: "06:00:00",
      lateClockIn: "08:00:59",
      endClockIn: "08:30:59",
      startBreak: "12:50:00",
      lateBreak: "13:00:59",
      endBreak: "13:30:59",
      startClockOut: "17:00:00",
      endClockOut: "23:59:59",
    ),
    WorkHourEntity(
      id: 2,
      code: "JK02",
      name: "Selasa",
      startClockIn: "06:00:00",
      lateClockIn: "08:00:59",
      endClockIn: "08:30:59",
      startBreak: "12:50:00",
      lateBreak: "13:00:59",
      endBreak: "13:30:59",
      startClockOut: "17:00:00",
      endClockOut: "23:59:59",
    ),
    WorkHourEntity(
      id: 3,
      code: "JK03",
      name: "Rabu",
      startClockIn: "06:00:00",
      lateClockIn: "08:00:59",
      endClockIn: "08:30:59",
      startBreak: "12:50:00",
      lateBreak: "13:00:59",
      endBreak: "13:30:59",
      startClockOut: "17:00:00",
      endClockOut: "23:59:59",
    ),
    WorkHourEntity(
      id: 4,
      code: "JK04",
      name: "Kamis",
      startClockIn: "06:00:00",
      lateClockIn: "08:00:59",
      endClockIn: "08:30:59",
      startBreak: "12:50:00",
      lateBreak: "13:00:59",
      endBreak: "13:30:59",
      startClockOut: "17:00:00",
      endClockOut: "23:59:59",
    ),
    WorkHourEntity(
      id: 5,
      code: "JK05",
      name: "Jumat",
      startClockIn: "06:00:00",
      lateClockIn: "08:00:59",
      endClockIn: "08:30:59",
      startBreak: "13:20:00",
      lateBreak: "13:30:59",
      endBreak: "14:00:59",
      startClockOut: "17:00:00",
      endClockOut: "23:59:59",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Penempatan dan Jam Kerja"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Penempatan Pekerja Harian"),
            CustomSearchDropdown<PlacementEntity>(
              items: _dummyPlacements,
              onChanged: (value) => setState(() => _selectedPlacement = value),
              itemAsString: (item) => item.name,
              itemFromId: (id) {
                return _dummyPlacements.firstWhere((e) => e.id == id);
              },
              itemId: (item) => item.id,
              hint: "Pilih cabang tujuan disini...",
            ),

            _buildLabel("Jam Kerja Pekerja Harian"),
            CustomSearchDropdown<WorkHourEntity>(
              items: _dummyWorkHours,
              onChanged: (value) => setState(() => _selectedWorkHour = value),
              itemAsString: (item) => item.name,
              itemFromId: (id) {
                return _dummyWorkHours.firstWhere((e) => e.id == id);
              },
              itemId: (item) => item.id,
              hint: "Pilih jam kerja disini...",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () {},
          child: Text("Simpan"),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
