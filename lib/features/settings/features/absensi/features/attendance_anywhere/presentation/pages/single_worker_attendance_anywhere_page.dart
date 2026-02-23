import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_dialog.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';

import '../../../../presentation/widgets/switch_option.dart';

class SingleWorkerAttendanceAnywherePage extends StatelessWidget {
  const SingleWorkerAttendanceAnywherePage({super.key});

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
                text: "Akses Absen Dimana Saja Orangan",
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
    return Scaffold(
      appBar: CustomAppBar(title: "Pengaturan Akses Absen Dimana Saja"),
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
              label: "Perizinan Absen Dimana Saja",
              description: "Izin untuk absen dimana saja bagi pekerja",
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
