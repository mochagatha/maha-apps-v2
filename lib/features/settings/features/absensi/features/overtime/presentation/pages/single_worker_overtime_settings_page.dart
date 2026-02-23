import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/settings/features/absensi/features/overtime/presentation/widget/switch_option.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_dialog.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';
import 'package:provider/provider.dart';

import '../provider/worker_overtime_settings_provider.dart';
import '../widget/percentage_slider.dart';

class SingleWorkerOvertimeSettingsPage extends StatelessWidget {
  const SingleWorkerOvertimeSettingsPage({super.key});

  void _submit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Maaf Sebelumnya...",
          assetImage: "assets/images/icon/submit-biodata.png",
          content: TextSpan(
            children: [
              TextSpan(text: "Apakah Anda yakin ingin menyimpan "),
              TextSpan(
                text: "Pengaturan Lembur Perorangan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: " ini?"),
            ],
          ),
          action: Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                  },
                  child: Text("Oke"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () => context.pop(),
                  child: Text("Batal"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<WorkerOvertimeSettingsProvider>();

    return Scaffold(
      appBar: CustomAppBar(title: "Pengaturan Lembur"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomLabel("Pekerja Harian"),
            SizedBox(height: 8),
            Row(
              children: [
                //-----------/ Foto /-----------//
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-----------/ Nama Karyawan /-----------//
                      Text(
                        "Akun Demo IT",
                        style: TextStyle(
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
                                //-----------/ NIK /-----------//
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_id_card.svg",
                                  label: "1234567",
                                ),

                                //-----------/ Status /-----------//
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_outline-phone.svg",
                                  label: "Aktif",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //-----------/ Posisi /-----------//
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_building.svg",
                                  label: "UI/UX Designer",
                                ),

                                //-----------/ Departemen /-----------//
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_building.svg",
                                  label: "Information Technology",
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
            SizedBox(height: 24),
            SwitchOption(
              label: "Pembukaan lembur karyawan",
              description: "Tanpa batasan waktu dan biaya",
            ),
            SizedBox(height: 12),
            SwitchOption(
              label: "Pembatasan lembur karyawan",
              description: "Ditentukan batas waktu atau biaya dalam presentase",
              onChanged: (value) => provider.showPercentage = value,
            ),
            Selector<WorkerOvertimeSettingsProvider, bool>(
              selector: (_, provider) => provider.showPercentage,
              builder: (context, show, child) {
                if (!show) return SizedBox();
                return PercentageSlider();
              },
            ),
            SizedBox(height: 12),
            SwitchOption(
              label: "Penutupan lembur karyawan",
              description: "Tidak ada waktu dan biaya lembur",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () => _submit(context),
          child: Text("Simpan"),
        ),
      ),
    );
  }

  Widget _buildMeta({required String assetIcon, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SvgPicture.asset(
            assetIcon,
            height: 20,
            width: 20,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomLabel extends StatelessWidget {
  const _CustomLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
