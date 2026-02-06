import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionDeniedDialog extends StatelessWidget {
  final Map<String, bool> deniedPermissions;
  final VoidCallback onOpenSettings;

  const PermissionDeniedDialog({
    super.key,
    required this.deniedPermissions,
    required this.onOpenSettings,
  });

  String _getPermissionName(String key) {
    switch (key) {
      case 'camera':
        return 'Kamera';
      case 'location':
        return 'Lokasi';
      case 'notification':
        return 'Notifikasi';
      default:
        return key;
    }
  }

  String _getPermissionDescription(String key) {
    switch (key) {
      case 'camera':
        return 'Diperlukan untuk fitur absensi dengan foto selfie dan deteksi wajah';
      case 'location':
        return 'Diperlukan untuk memverifikasi lokasi saat absensi';
      case 'notification':
        return 'Diperlukan untuk menerima pemberitahuan penting dari aplikasi';
      default:
        return '';
    }
  }

  List<String> _getPermanentlyDeniedList() {
    return deniedPermissions.entries
        .where(
          (entry) => entry.value == true && entry.key != 'notification',
        ) // Exclude notification from dialog
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final deniedList = _getPermanentlyDeniedList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: Colors.orange.shade50, shape: BoxShape.circle),
              child: Icon(Icons.warning_amber_rounded, size: 40, color: Colors.orange.shade700),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              'Izin Diperlukan',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              'Beberapa izin telah ditolak secara permanen. Anda perlu mengaktifkannya melalui Pengaturan.',
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Denied permissions list
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Izin yang Ditolak:',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...deniedList.map(
                    (key) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getPermissionName(key),
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _getPermissionDescription(key),
                                  style: GoogleFonts.outfit(fontSize: 12, color: Colors.black54),
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
            ),
            const SizedBox(height: 20),

            // Instructions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Cara mengaktifkan: Buka Pengaturan → Izin → Aktifkan izin yang diperlukan',
                      style: GoogleFonts.outfit(fontSize: 12, color: Colors.blue.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Nanti',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(233, 30, 33, 1),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onOpenSettings();
                    },
                    child: Text(
                      'Buka Pengaturan',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
