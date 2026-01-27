import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../data/datasources/recruitment_remote_datasource.dart';

class CompanyCodePage extends StatefulWidget {
  const CompanyCodePage({super.key});

  @override
  State<CompanyCodePage> createState() => _CompanyCodePageState();
}

class _CompanyCodePageState extends State<CompanyCodePage> {
  String _companyCode = ""; // Will be loaded from API
  bool _isLoading = true;
  String? _errorMessage;
  late final RecruitmentRemoteDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = sl<RecruitmentRemoteDataSource>();
    _loadCompanyCode();
  }

  Future<void> _loadCompanyCode() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final companyCodeData = await _dataSource.getCompanyCode();

      setState(() {
        _companyCode = companyCodeData.code;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('ServerException: ', '');
        _companyCode = "------"; // Show placeholder on error
      });
    }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _isLoading ? null : _loadCompanyCode,
            tooltip: 'Refresh Kode',
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Gagal Memuat Kode Perusahaan',
                            style: AppTextStyles.headingTwoSemiBold(context),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _errorMessage!,
                            style: AppTextStyles.bodyStyle(context),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _loadCompanyCode,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          // Title Section
                          Text(
                            'Gunakan Kode Perusahdikelola oleh sistem dan akan berganti secara otomatis',
                            style: AppTextStyles.bodyStyle(
                              context,
                            ).copyWith(color: Colors.black87, fontSize: 12),
                          ),
                          const SizedBox(height: 24),
                          // Code Display Section
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
