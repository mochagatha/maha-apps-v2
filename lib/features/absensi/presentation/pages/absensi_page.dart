import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/attendance_provider.dart';
import '../widgets/absensi_app_bar.dart';
import '../widgets/date_time_display.dart';
import '../widgets/attendance_card.dart';
import 'camera_page.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  int? _employeeId;
  int? _jobTitleId;
  String? _branchCode;
  String? _employeeType;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEmployeeData();
  }

  Future<void> _loadEmployeeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _employeeId = prefs.getInt('employee_id');
      _jobTitleId = prefs.getInt('job_title_id');
      _branchCode = prefs.getString('branch_code');
      _employeeType = prefs.getString('type');
      _isLoading = false;
    });

    if (_employeeId != null && _jobTitleId != null && mounted) {
      context.read<AttendanceProvider>().loadData(
        employeeId: _employeeId!,
        jobTitleId: _jobTitleId!,
        parentMenuId: 1,
        isWorker: _employeeType == 'worker',
      );
    }
  }

  Future<void> _refresh() async {
    if (_employeeId != null && _jobTitleId != null) {
      await context.read<AttendanceProvider>().loadData(
        employeeId: _employeeId!,
        jobTitleId: _jobTitleId!,
        parentMenuId: 1,
        isWorker: _employeeType == 'worker',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<AttendanceProvider>(
          builder: (context, provider, child) {
            if (_isLoading || provider.isLoading) {
              return Stack(
                children: [
                  const AbsensiAppBar(),
                  const Center(
                    child: SpinKitThreeBounce(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                  ),
                ],
              );
            }

            if (provider.hasError) {
              return Stack(
                children: [
                  const AbsensiAppBar(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(provider.errorMessage ?? 'Error'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refresh,
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (provider.attendanceToday == null) {
              return Stack(
                children: [
                  const AbsensiAppBar(),
                  const Center(child: Text('Tidak ada data')),
                ],
              );
            }

            final data = provider.attendanceToday!;
            final hasClockOut =
                data.clockOut != null && data.clockOut != 'null';
            final hasClockIn = data.clockIn != null && data.clockIn != 'null';

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _refresh,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // App Bar
                  const AbsensiAppBar(),

                  // Main Card
                  Positioned(
                    top: 115,
                    left: 18,
                    right: 18,
                    bottom: 0,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Date & Time
                              const DateTimeDisplay(),
                              const SizedBox(height: 20),

                              // Clock In & Clock Out Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AttendanceCard(
                                    title: 'Masuk',
                                    time: data.clockIn,
                                    photoUrl: data.photoInUrl,
                                    colorStatus: data.isLate ?? 0,
                                    isLate: (data.isLate ?? 0) > 0,
                                    clockType: data.clockInType ?? 1,
                                  ),
                                  AttendanceCard(
                                    title: 'Pulang',
                                    time: data.clockOut,
                                    photoUrl: data.photoOutUrl,
                                    colorStatus: data.earlyOut ?? 6,
                                    clockType: data.clockOutType ?? 1,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Break
                              AttendanceCard(
                                title: 'Istirahat',
                                time: data.breakFinish,
                                photoUrl: data.breakFinishPhoto,
                                colorStatus: data.breakFinish == null
                                    ? 9
                                    : (data.isLateBreak ?? 0),
                                clockType: data.breakFinishType ?? 1,
                              ),

                              // Overtime (if exists)
                              if (data.overtimeStart != null &&
                                  data.overtimeStart != 'null') ...[
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    AttendanceCard(
                                      title: 'Lembur',
                                      time: data.overtimeStart,
                                      photoUrl: data.overtimeStartPhotoUrl,
                                      colorStatus: 20,
                                    ),
                                    const Spacer(),
                                    AttendanceCard(
                                      title: 'Lembur',
                                      time: data.overtimeFinish,
                                      photoUrl: data.overtimeFinishPhotoUrl,
                                      colorStatus: data.overtimeFinish == null
                                          ? 6
                                          : 20,
                                    ),
                                  ],
                                ),
                              ],

                              // Action Button (only if not completed)
                              if (!hasClockOut || !hasClockIn) ...[
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: provider.isSubmitting
                                      ? const Center(
                                          child: SpinKitThreeBounce(
                                            color: AppColors.primary,
                                            size: 24.0,
                                          ),
                                        )
                                      : ElevatedButton.icon(
                                          onPressed: () async {
                                            if (_employeeId == null ||
                                                _branchCode == null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Data karyawan tidak ditemukan',
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CameraPage(
                                                  status: provider
                                                      .determineAttendanceStatus(),
                                                  onPhotoTaken: (photoPath, location) async {
                                                    await provider
                                                        .submitAttendance(
                                                          employeeId:
                                                              _employeeId!,
                                                          photoPath: photoPath,
                                                          location: location,
                                                          branchCode:
                                                              _branchCode!,
                                                          isWorker:
                                                              _employeeType ==
                                                              'worker',
                                                        );

                                                    if (provider.errorMessage ==
                                                        null) {
                                                      if (context.mounted) {
                                                        await context
                                                            .read<
                                                              AttendanceProvider
                                                            >()
                                                            .loadData(
                                                              employeeId:
                                                                  _employeeId!,
                                                              jobTitleId:
                                                                  _jobTitleId!,
                                                              parentMenuId: 1,
                                                              isWorker:
                                                                  _employeeType ==
                                                                  'worker',
                                                            );
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'Absensi berhasil!',
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      if (context.mounted) {
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              provider
                                                                  .errorMessage!,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.photo_camera),
                                          label: Text(
                                            hasClockIn == false
                                                ? 'Ambil Absen Masuk'
                                                : data.breakFinish == null
                                                ? 'Ambil Absen Istirahat'
                                                : 'Ambil Absen Pulang',
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: Colors.white,
                                            minimumSize: const Size(
                                              double.infinity,
                                              45,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                ),
                              ],

                              const SizedBox(height: 20),

                              // Menu Grid (if available)
                              if (provider.menuIDs.isNotEmpty)
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1.2,
                                      ),
                                  itemCount: provider.menuIDs.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 2,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            provider.menuIDs[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
