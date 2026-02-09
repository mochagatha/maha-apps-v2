import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../domain/entities/tracking_employee.dart';
import '../providers/pelacakan_provider.dart';

class EmployeeDetailPage extends StatefulWidget {
  final TrackingEmployee employee;

  const EmployeeDetailPage({
    super.key,
    required this.employee,
  });

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  late bool _isTrackingEnabled;

  @override
  void initState() {
    super.initState();
    _isTrackingEnabled = widget.employee.isTrackingEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          // Check if tracking status has changed
          if (_isTrackingEnabled != widget.employee.isTrackingEnabled) {
            // Update in provider before popping
            context.read<PelacakanProvider>().toggleEmployeeTracking(
              widget.employee.id,
              _isTrackingEnabled,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Perubahan berhasil disimpan sementara. Simpan di halaman pengaturan untuk menyimpan permanen.',
                ),
                backgroundColor: AppColors.primary,
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: widget.employee.fullname),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employee Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            backgroundImage: widget.employee.photoUrl != null
                                ? NetworkImage(widget.employee.photoUrl!)
                                : null,
                            child: widget.employee.photoUrl == null
                                ? Text(
                                    widget.employee.fullname.isNotEmpty
                                        ? widget.employee.fullname[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Employee Details
                          _buildDetailRow(
                            Icons.badge,
                            'ID',
                            widget.employee.employeeId,
                          ),
                          const Divider(height: 24),
                          _buildDetailRow(
                            Icons.work,
                            'Jabatan',
                            widget.employee.jobTitleName,
                          ),
                          if (widget.employee.departmentName != null) ...[
                            const Divider(height: 24),
                            _buildDetailRow(
                              Icons.business,
                              'Departemen',
                              widget.employee.departmentName!,
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tracking Settings
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pelacakan Jam Kerja',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Aktifkan Pelacakan Jam Kerja Karyawan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isTrackingEnabled,
                            onChanged: (value) {
                              setState(() {
                                _isTrackingEnabled = value;
                              });
                            },
                            activeColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: CustomElevatedButton(
              onPressed: _handleSave,
              child: const Text('Simpan'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSave() {
    // Update in provider
    context.read<PelacakanProvider>().toggleEmployeeTracking(
      widget.employee.id,
      _isTrackingEnabled,
    );

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Perubahan berhasil disimpan sementara. Jangan lupa simpan di halaman pengaturan.',
        ),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 2),
      ),
    );

    // Pop back to settings page
    context.pop();
  }
}
