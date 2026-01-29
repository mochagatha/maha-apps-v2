import 'package:flutter/material.dart';

class EmploymentLevelListPage extends StatelessWidget {
  const EmploymentLevelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Tingkatan Pekerjaan'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              size: 120,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            const Text(
              'Halaman Data Tingkatan Pekerjaan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Fitur ini akan segera hadir',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
