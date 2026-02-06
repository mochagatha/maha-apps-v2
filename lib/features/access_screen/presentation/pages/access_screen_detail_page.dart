import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../providers/access_screen_provider.dart';
import '../widgets/custom_switch.dart';

class AccessScreenDetailPage extends StatefulWidget {
  final int id;
  final String type;

  const AccessScreenDetailPage({super.key, required this.id, required this.type});

  @override
  State<AccessScreenDetailPage> createState() => _AccessScreenDetailPageState();
}

class _AccessScreenDetailPageState extends State<AccessScreenDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccessScreenProvider>().fetchDetail(widget.type, widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pengaturan Akses Layar", centerTitle: true),
      body: Consumer<AccessScreenProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          if (provider.detailData == null) {
            return Center(
              child: Text(
                provider.errorMessage.isEmpty ? 'Data tidak ditemukan' : provider.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          final data = provider.detailData!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(data.photoUrl),
                      onBackgroundImageError: (_, __) {},
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.fullname,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5F5F5F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data.jobTitle,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            data.department,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        title: "Tangkap Layar",
                        description: "Izin untuk menangkap layar bagi karyawan",
                        isActive: provider.isDetailCatch,
                        onChanged: (value) {
                          provider.isDetailCatch = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildSwitchTile(
                        title: "Rekam Layar",
                        description: "Izin untuk merekam layar bagi karyawan",
                        isActive: provider.isDetailRecord,
                        onChanged: (value) {
                          provider.isDetailRecord = value;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<AccessScreenProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return ConfirmDialog(
                          title: "Konfirmasi",
                          message: "Apakah Anda yakin ingin menyimpan perubahan?",
                          onConfirm: () async {
                            // Save navigator reference before async operation
                            final dialogNavigator = Navigator.of(dialogContext);

                            LoadingDialog.show(dialogContext);
                            final success = await provider.updateDetail();

                            // Use saved navigator to close loading dialog
                            if (dialogNavigator.canPop()) {
                              dialogNavigator.pop();
                            }

                            if (success && context.mounted) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const SuccessDialog(message: "Berhasil menyimpan pengaturan"),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String description,
    required bool isActive,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CustomSwitch(value: isActive, onChanged: onChanged),
      ],
    );
  }
}
