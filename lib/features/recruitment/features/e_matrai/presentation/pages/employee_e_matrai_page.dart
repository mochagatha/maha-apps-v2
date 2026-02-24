import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/core/di/injection_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_item.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/presentation/providers/e_matrai_provider.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_tab_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/network/api_client.dart';

class EmployeeEMatraiPage extends StatelessWidget {
  /// 'employee' or 'worker'
  final String typeUser;

  const EmployeeEMatraiPage({super.key, this.typeUser = 'employee'});

  @override
  Widget build(BuildContext context) {
    final statusList = ['Baru', 'Upload', 'Selesai'];

    return DefaultTabController(
      length: statusList.length,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Upload E-Matrai'),
        body: Column(
          children: [
            CustomTabBar(statusList: statusList, showAll: false),
            Expanded(
              child: TabBarView(
                children: List.generate(statusList.length, (statusIndex) {
                  return _TabContent(
                    matraiStatus: statusIndex,
                    typeUser: typeUser,
                    statusText: statusList[statusIndex],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab body – lazy-loads data when first visible
// ---------------------------------------------------------------------------
class _TabContent extends StatefulWidget {
  const _TabContent({
    required this.matraiStatus,
    required this.typeUser,
    required this.statusText,
  });

  final int matraiStatus;
  final String typeUser;
  final String statusText;

  @override
  State<_TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<_TabContent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EMatraiProvider>().fetchTab(
        widget.matraiStatus,
        typeUser: widget.typeUser,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<EMatraiProvider>(
      builder: (context, provider, _) {
        final tabState = provider.stateForTab(widget.matraiStatus);

        if (tabState.status == EMatraiStatus.loading || tabState.status == EMatraiStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tabState.status == EMatraiStatus.error) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tabState.errorMessage ?? 'Terjadi kesalahan',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => provider.fetchTab(
                    widget.matraiStatus,
                    typeUser: widget.typeUser,
                  ),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final items = tabState.items;

        if (items.isEmpty) {
          return const Center(child: Text('Tidak ada data'));
        }

        return RefreshIndicator(
          onRefresh: () => provider.fetchTab(
            widget.matraiStatus,
            typeUser: widget.typeUser,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _DataItem(item: item, statusText: widget.statusText);
            },
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Single card
// ---------------------------------------------------------------------------
class _DataItem extends StatefulWidget {
  const _DataItem({required this.item, required this.statusText});

  final EMatraiItem item;
  final String statusText;

  @override
  State<_DataItem> createState() => _DataItemState();
}

class _DataItemState extends State<_DataItem> {
  File? _selectedFile;
  bool _isDownloading = false;
  double _downloadProgress = 0;

  Uri? _normalizeDownloadUri(String rawUrl) {
    final trimmedUrl = rawUrl.trim();
    if (trimmedUrl.isEmpty) return null;

    try {
      final parsed = Uri.parse(trimmedUrl);
      if (!parsed.hasScheme || parsed.host.isEmpty) {
        return null;
      }

      return parsed.replace(pathSegments: parsed.pathSegments);
    } catch (_) {
      return null;
    }
  }

  String _sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }

  Future<void> _downloadFile(BuildContext context, String url) async {
    if (_isDownloading) return;

    final downloadUri = _normalizeDownloadUri(url);
    if (downloadUri == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('URL lampiran tidak valid.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Request storage permission on Android
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        // Try manageExternalStorage for Android 11+
        final manageStatus = await Permission.manageExternalStorage.request();
        if (!manageStatus.isGranted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Izin penyimpanan diperlukan untuk mengunduh file.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      }
    }

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    try {
      // Determine save directory
      Directory saveDir;
      if (Platform.isAndroid) {
        saveDir = Directory('/storage/emulated/0/Download');
        if (!await saveDir.exists()) {
          saveDir = await getApplicationDocumentsDirectory();
        }
      } else {
        saveDir = await getApplicationDocumentsDirectory();
      }

      // Build file name from URL
      final resolvedFileName = downloadUri.pathSegments.isNotEmpty
          ? downloadUri.pathSegments.last
          : 'attachment_${DateTime.now().millisecondsSinceEpoch}.bin';
      final fileName = _sanitizeFileName(resolvedFileName);
      final savePath = '${saveDir.path}/$fileName';

      final dio = sl<ApiClient>().dio;
      DioException? lastError;

      for (var attempt = 0; attempt < 3; attempt++) {
        try {
          await dio.downloadUri(
            downloadUri,
            savePath,
            options: Options(
              receiveTimeout: const Duration(seconds: 120),
              sendTimeout: const Duration(seconds: 120),
              followRedirects: true,
              persistentConnection: false,
              headers: const {
                'Accept': '*/*',
              },
            ),
            onReceiveProgress: (received, total) {
              if (total > 0) {
                setState(() {
                  _downloadProgress = received / total;
                });
              }
            },
          );
          lastError = null;
          break;
        } on DioException catch (e) {
          lastError = e;
          if (attempt < 2) {
            await Future.delayed(Duration(milliseconds: 600 * (attempt + 1)));
            continue;
          }
        }
      }

      if (lastError != null) {
        throw lastError;
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File berhasil diunduh ke $savePath'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        final message = e is DioException
            ? (e.message ?? 'Terjadi kesalahan saat mengunduh file')
            : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengunduh file: $message'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isDownloading = false;
        _downloadProgress = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.item.matraiStatus;
    final employee = widget.item.employee;
    final safeStatus = status.clamp(0, 2);

    final backgroundColors = [
      Colors.blue.withAlpha(40),
      const Color(0xFFFFF5CD),
      const Color(0xFFF0FFF0),
    ];
    final foregroundColors = [
      AppColors.blue,
      const Color(0xFFBE9621),
      Colors.green.shade700,
    ];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shadowColor: Colors.black38,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // Status badge
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: backgroundColors[safeStatus],
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  widget.item.matraiStatusDescription.isNotEmpty
                      ? _capitalize(widget.item.matraiStatusDescription)
                      : widget.statusText,
                  style: TextStyle(
                    color: foregroundColors[safeStatus],
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Employee row
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: employee.photoUrl.isNotEmpty
                      ? Image.network(
                          employee.photoUrl,
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _photoPlaceholder(),
                        )
                      : _photoPlaceholder(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.fullname,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMeta(
                                  assetIcon: 'assets/images/icon/ic_id_card.svg',
                                  label: employee.nik,
                                ),
                                _buildMeta(
                                  assetIcon: 'assets/images/icon/ic_outline-phone.svg',
                                  label: employee.phoneNumber.isNotEmpty
                                      ? employee.phoneNumber
                                      : '-',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMeta(
                                  assetIcon: 'assets/images/icon/ic_building.svg',
                                  label: widget.item.departmentName.isNotEmpty
                                      ? widget.item.departmentName
                                      : employee.departmentName,
                                ),
                                _buildMeta(
                                  assetIcon: 'assets/images/icon/ic_building.svg',
                                  label: widget.item.jobTitleName.isNotEmpty
                                      ? widget.item.jobTitleName
                                      : employee.jobTitleName,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // PDF attachment
            if (widget.item.attachmentUrl.isNotEmpty)
              _buildAttachment(
                title: 'Surat Perjanjian Kerja',
                attachmentUrl: widget.item.attachmentUrl,
                createdAt: widget.item.createdAt,
              ),

            // Upload button
            if (safeStatus < 2 && _selectedFile == null) ...[
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => setState(() => _selectedFile = File('')),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.blue),
                  foregroundColor: AppColors.blue,
                  backgroundColor: AppColors.blue.withAlpha(20),
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon/ic_file.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.blue,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Upload Surat Perjanjian Kerja (e-matrai)',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],

            // Selected file + submit
            if (_selectedFile != null) ...[
              _buildAttachment(
                title: 'Surat Perjanjian Kerja (E-Matrai)',
                attachmentUrl: '',
                createdAt: DateTime.now().toIso8601String(),
                selectedFile: _selectedFile,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {},
                  child: const Text('Selesai'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _photoPlaceholder() => Container(
    height: 64,
    width: 64,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Icon(Icons.person, color: Colors.white, size: 36),
  );

  Widget _buildMeta({required String assetIcon, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SvgPicture.asset(assetIcon, height: 20, width: 20),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachment({
    required String title,
    required String attachmentUrl,
    required String createdAt,
    File? selectedFile,
  }) {
    DateTime date;
    try {
      date = DateTime.parse(createdAt);
    } catch (_) {
      date = DateTime.now();
    }
    final dateString = DateFormat('dd MMMM yyyy').format(date);

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/icon/logo_pdf.svg', height: 36, width: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text('Diunggah $dateString', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          if (attachmentUrl.isNotEmpty)
            _isDownloading
                ? SizedBox(
                    width: 64,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LinearProgressIndicator(
                          value: _downloadProgress > 0 ? _downloadProgress : null,
                          backgroundColor: Colors.blue.withAlpha(40),
                          color: AppColors.blue,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _downloadProgress > 0 ? '${(_downloadProgress * 100).toInt()}%' : '...',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: () => _downloadFile(context, attachmentUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      'Unduh',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
          if (selectedFile != null)
            IconButton(
              onPressed: () => setState(() => _selectedFile = null),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(6),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              icon: const Icon(Icons.delete, size: 20),
            ),
        ],
      ),
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
