import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/screen_security_provider.dart';

/// Widget untuk menampilkan status screen security
/// Hanya muncul di debug mode
class ScreenSecurityStatusWidget extends StatelessWidget {
  const ScreenSecurityStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Hanya tampilkan di debug mode
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return Consumer<ScreenSecurityProvider>(
      builder: (context, provider, child) {
        final isEnabled = provider.isSecurityEnabled;
        final settings = provider.securitySettings;

        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isEnabled ? Colors.red.shade100 : Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isEnabled ? Colors.red : Colors.green, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isEnabled ? Icons.lock : Icons.lock_open,
                    color: isEnabled ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isEnabled
                          ? '🔒 Screenshot Protection ENABLED'
                          : '🔓 Screenshot Protection DISABLED',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isEnabled ? Colors.red.shade900 : Colors.green.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              if (settings != null) ...[
                const SizedBox(height: 8),
                Text('API Settings:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('  • is_catch: ${settings.isCatch}'),
                Text('  • is_record: ${settings.isRecord}'),
                Text('  • employee_id: ${settings.employeeWorkerId}'),
                Text('  • type: ${settings.type}'),
              ],
              if (provider.status == ScreenSecurityStatus.error) ...[
                const SizedBox(height: 8),
                Text(
                  'Error: ${provider.errorMessage}',
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
