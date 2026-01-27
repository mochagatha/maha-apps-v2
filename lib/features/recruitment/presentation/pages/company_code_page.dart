import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';

class CompanyCodePage extends StatefulWidget {
  const CompanyCodePage({super.key});

  @override
  State<CompanyCodePage> createState() => _CompanyCodePageState();
}

class _CompanyCodePageState extends State<CompanyCodePage> {
  Timer? _timer;
  int _remainingTime = 86400; // 24 hours in seconds
  String _companyCode = "193244"; // Example code, in real implementation this would come from API

  @override
  void initState() {
    super.initState();
    startTimer();
    // In real implementation, fetch the company code from API
    _loadCompanyCode();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
        // Refresh company code when time expires
        _loadCompanyCode();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  Future<void> _loadCompanyCode() async {
    // TODO: Implement API call to get company code
    // For now, using static code
    setState(() {
      _companyCode = "193244";
      _remainingTime = 86400; // Reset to 24 hours
    });
  }

  String get timerText {
    final hours = (_remainingTime ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_remainingTime % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const FaIcon(FontAwesomeIcons.circleChevronLeft, color: Colors.white, size: 24),
          ),
        ),
        title: const Text(
          'Kode Perusahaan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Title Section
                Text(
                  'Gunakan Kode Perusahaan',
                  style: AppTextStyles.headingTwoSemiBold(
                    context,
                  ).copyWith(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Text(
                  'Kode perusahaan ini akan berganti setiap 1 x 24 Jam',
                  style: AppTextStyles.bodyStyle(
                    context,
                  ).copyWith(color: Colors.black87, fontSize: 12),
                ),
                const SizedBox(height: 24),
                // Timer Icon and Code Display Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timer Icon
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Icon(Icons.access_time_rounded, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    // Code Display
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _companyCode.split('').map((digit) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFF404040), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                digit,
                                style: const TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
