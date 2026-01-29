import 'package:flutter/material.dart';

class JobTitleListPage extends StatelessWidget {
  const JobTitleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Jabatan'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.badge_outlined,
              size: 120,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            const Text(
              'Halaman Data Jabatan',
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
