import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/attendance_provider.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  @override
  void initState() {
    super.initState();
    // Load data after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO: Get actual IDs from somewhere (Arguments or Auth Provider)
      // For now, we rely on hardcoded or looked up values if not provided.
      // But typically check-in requires basic employee ID.
      // We'll assuming AuthProvider is accessible or similar.
      // For this refactor, I will add a TODO or mock.
      // context.read<AttendanceProvider>().loadData(employeeId: 1, jobTitleId: 1, parentMenuId: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi'),
        centerTitle: true,
      ),
      body: Consumer<AttendanceProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
             return const Center(child: CircularProgressIndicator());
          }
          if (provider.hasError) {
             return Center(child: Text(provider.errorMessage ?? 'Error'));
          }
          if (provider.attendanceToday == null) {
             return const Center(child: Text('No Data'));
          }

          final data = provider.attendanceToday!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Date & Time
                Text(
                  '${DateTime.now()}', // TODO: Format date properly
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),

                // Attendance Cards Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     _buildTimeCard('Masuk', data.clockIn ?? '-'),
                     _buildTimeCard('Pulang', data.clockOut ?? '-'),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Break Card
                 _buildTimeCard('Istirahat', data.breakFinish ?? '-'),

                 const SizedBox(height: 20),

                 // Overtime (if exists)
                 if (data.overtimeStart != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTimeCard('Lembur Masuk', data.overtimeStart ?? '-'),
                        _buildTimeCard('Lembur Pulang', data.overtimeFinish ?? '-'),
                      ],
                    ),
                    const SizedBox(height: 20),
                 ],

                 // Action Button
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton.icon(
                     onPressed: () {
                        // Navigate to Camera/Face Check
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Camera feature coming soon')),
                        );
                     }, 
                     icon: const Icon(Icons.camera_alt), 
                     label: const Text('Ambil Absensi'),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.primary,
                       foregroundColor: Colors.white,
                       padding: const EdgeInsets.symmetric(vertical: 12),
                     ),
                   ),
                 ),

                 const SizedBox(height: 30),
                 
                 // Menu Grid (Features)
                 if (provider.menuIDs.isNotEmpty) 
                   GridView.builder(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                       crossAxisSpacing: 10,
                       mainAxisSpacing: 10,
                     ),
                     itemCount: provider.menuIDs.length,
                     itemBuilder: (context, index) {
                       return Card(
                         child: Center(child: Text(provider.menuIDs[index], textAlign: TextAlign.center)),
                       );
                     },
                   ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeCard(String title, String time) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(time, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
