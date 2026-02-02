import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeDisplay extends StatefulWidget {
  const DateTimeDisplay({super.key});

  @override
  State<DateTimeDisplay> createState() => _DateTimeDisplayState();
}

class _DateTimeDisplayState extends State<DateTimeDisplay> {
  late Stream<DateTime> _timeStream;
  String? _timeZone;

  @override
  void initState() {
    super.initState();
    try {
      tz.initializeTimeZones();
    } catch (e) {
      // Already initialized
    }
    _timeZone = _getTimeZone();
    _timeStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (x) => DateTime.now(),
    ).asBroadcastStream();
  }

  String? _getTimeZone() {
    try {
      final location = tz.getLocation('Asia/Jakarta');
      final now = tz.TZDateTime.now(location);
      if (now.timeZoneOffset.inHours == 7) {
        return 'WIB';
      } else if (now.timeZoneOffset.inHours == 8) {
        return 'WITA';
      } else if (now.timeZoneOffset.inHours == 9) {
        return 'WIT';
      }
    } catch (e) {
      return 'WIB';
    }
    return 'WIB';
  }

  String _formatDate(DateTime date) {
    final days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final dayName = days[date.weekday % 7];
    final day = date.day;
    final month = months[date.month - 1];
    final year = date.year;

    return '$dayName, $day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_formatDate(DateTime.now()), style: const TextStyle(fontSize: 14)),
        const Spacer(),
        const Icon(Icons.watch_later_outlined, size: 16),
        const SizedBox(width: 8),
        StreamBuilder<DateTime>(
          stream: _timeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final time = snapshot.data!;
              final formattedTime =
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${_timeZone ?? ''}';
              return Text(
                formattedTime,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              );
            } else {
              return const Text('--:-- WIB');
            }
          },
        ),
      ],
    );
  }
}
