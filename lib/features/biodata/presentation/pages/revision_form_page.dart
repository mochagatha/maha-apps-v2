import 'package:flutter/material.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/biodata_revision_provider.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_dialog.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class RevisionFormPage extends StatefulWidget {
  const RevisionFormPage({super.key});

  @override
  State<RevisionFormPage> createState() => _RevisionFormPageState();
}

class _RevisionFormPageState extends State<RevisionFormPage> {
  late final BiodataRevisionProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<BiodataRevisionProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.load());
  }

  Future<void> _submitRevision() async {
    final success = await _provider.submit();
    if (!mounted) return;

    if (success) {
      showDialog(
        context: context,
        builder: (_) => CustomDialog(
          title: "Data Diri Berhasil Dikirim",
          assetImage: "assets/images/icon/verifikasi-data.png",
          content: const TextSpan(
            children: [
              TextSpan(
                children: [
                  TextSpan(text: "Mohon untuk menunggu "),
                  TextSpan(
                    text: "Verifikasi Data Diri",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " Anda dari HRD Maha!"),
                ],
              ),
            ],
          ),
          action: CustomElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icon/whatsapp.png",
                  height: 16,
                  width: 16,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Hubungi Admin',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (_provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_provider.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Perbaikan Data Diri"),
      body: Consumer<BiodataRevisionProvider>(
        builder: (context, provider, _) {
          if (provider.status == RevisionStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.status == RevisionStatus.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      provider.errorMessage ?? 'Terjadi kesalahan',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CustomElevatedButton(
                      onPressed: provider.load,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          return _buildForm(provider);
        },
      ),
      bottomNavigationBar: Consumer<BiodataRevisionProvider>(
        builder: (context, provider, _) {
          final isLoading =
              provider.status == RevisionStatus.loading ||
              provider.status == RevisionStatus.submitting;
          final isLoaded =
              provider.status == RevisionStatus.loaded ||
              provider.status == RevisionStatus.submitted;

          if (!isLoaded) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.all(12),
            child: CustomElevatedButton(
              onPressed: isLoading ? () {} : () => _submitRevision(),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Perbaiki"),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(BiodataRevisionProvider p) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Catatan revisi dari HR
          if (p.revisionDescription != null && p.revisionDescription!.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                border: Border.all(color: Colors.orange.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Catatan dari HR:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.revisionDescription!,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── Informasi Pribadi ──────────────────────────────────────────
          if (p.showBiodataSection) ...[
            _buildHeading("Informasi Pribadi"),
            if (p.showBiodataFullname)
              _buildField(
                controller: p.nameController,
                label: "Nama Lengkap",
                hint: "Masukkan nama lengkap...",
              ),
            if (p.showBiodataNickname)
              _buildField(
                controller: p.nicknameController,
                label: "Nama Panggilan",
                hint: "Masukkan nama panggilan...",
              ),
            if (p.showBiodataNik)
              _buildField(
                controller: p.nikController,
                label: "NIK",
                hint: "Masukkan NIK...",
                keyboardType: TextInputType.number,
              ),
            if (p.showBiodataBirth) ...[
              _buildField(
                controller: p.birthPlaceController,
                label: "Tempat Lahir",
                hint: "Masukkan tempat lahir...",
              ),
              _buildField(
                controller: p.birthDateController,
                label: "Tanggal Lahir",
                hint: "YYYY-MM-DD",
                keyboardType: TextInputType.datetime,
              ),
            ],
            if (p.showBiodataGender)
              _buildField(
                controller: p.genderController,
                label: "Jenis Kelamin",
                hint: "L / P",
              ),
            if (p.showBiodataReligion)
              _buildField(
                controller: p.religionController,
                label: "Agama",
                hint: "Masukkan agama...",
              ),
            if (p.showBiodataBloodType)
              _buildField(
                controller: p.bloodTypeController,
                label: "Golongan Darah",
                hint: "A / B / AB / O",
              ),
            if (p.showBiodataBody) ...[
              _buildField(
                controller: p.weightController,
                label: "Berat Badan (kg)",
                hint: "Masukkan berat badan...",
                keyboardType: TextInputType.number,
              ),
              _buildField(
                controller: p.heightController,
                label: "Tinggi Badan (cm)",
                hint: "Masukkan tinggi badan...",
                keyboardType: TextInputType.number,
              ),
            ],
            if (p.showBiodataPhone)
              _buildField(
                controller: p.phoneController,
                label: "No. HP",
                hint: "Masukkan nomor HP...",
                keyboardType: TextInputType.phone,
              ),
            if (p.showBiodataEmergencyPhone)
              _buildField(
                controller: p.emergencyPhoneController,
                label: "No. HP Darurat",
                hint: "Masukkan nomor HP darurat...",
                keyboardType: TextInputType.phone,
              ),
            if (p.showBiodataResidenceStatus)
              _buildField(
                controller: p.residenceStatusController,
                label: "Status Tempat Tinggal",
                hint: "Kost / Rumah Sendiri / dll...",
              ),
            if (p.showBiodataIdentityAddress)
              _buildField(
                controller: p.identityAddressController,
                label: "Alamat KTP",
                hint: "Masukkan alamat sesuai KTP...",
                maxLines: 3,
              ),
            if (p.showBiodataCurrentAddress)
              _buildField(
                controller: p.currentAddressController,
                label: "Alamat Domisili",
                hint: "Masukkan alamat domisili...",
                maxLines: 3,
              ),
          ],

          // ── Pendidikan SD ─────────────────────────────────────────────
          if (p.showEducationSd) ...[
            _buildHeading("SD"),
            _buildField(
              controller: p.primarySchoolController,
              label: "Nama Sekolah",
              hint: "Masukkan nama sekolah SD...",
            ),
            _buildField(
              controller: p.psStartYearController,
              label: "Tahun Masuk",
              hint: "Contoh: 2000",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.psEndYearController,
              label: "Tahun Keluar",
              hint: "Contoh: 2006",
              keyboardType: TextInputType.number,
            ),
          ],

          // ── Pendidikan SMP ────────────────────────────────────────────
          if (p.showEducationSmp) ...[
            _buildHeading("SMP/MTs"),
            _buildField(
              controller: p.juniorHighSchoolController,
              label: "Nama Sekolah",
              hint: "Masukkan nama sekolah SMP...",
            ),
            _buildField(
              controller: p.jhsStartYearController,
              label: "Tahun Masuk",
              hint: "Contoh: 2006",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.jhsEndYearController,
              label: "Tahun Keluar",
              hint: "Contoh: 2009",
              keyboardType: TextInputType.number,
            ),
          ],

          // ── Pendidikan SMA ────────────────────────────────────────────
          if (p.showEducationSma) ...[
            _buildHeading("SMA/SMK/MAN"),
            _buildField(
              controller: p.seniorHighSchoolController,
              label: "Nama Sekolah",
              hint: "Masukkan nama sekolah SMA...",
            ),
            _buildField(
              controller: p.shsStartYearController,
              label: "Tahun Masuk",
              hint: "Contoh: 2009",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.shsEndYearController,
              label: "Tahun Keluar",
              hint: "Contoh: 2012",
              keyboardType: TextInputType.number,
            ),
          ],

          // ── Pendidikan S1 ─────────────────────────────────────────────
          if (p.showEducationS1) ...[
            _buildHeading("S1"),
            _buildField(
              controller: p.bachelorUniversityController,
              label: "Nama Universitas",
              hint: "Masukkan nama universitas...",
            ),
            _buildField(
              controller: p.bachelorMajorController,
              label: "Jurusan",
              hint: "Masukkan jurusan...",
            ),
            _buildField(
              controller: p.bachelorStartYearController,
              label: "Tahun Masuk",
              hint: "Contoh: 2012",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.bachelorEndYearController,
              label: "Tahun Keluar",
              hint: "Contoh: 2016",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.bachelorGpaController,
              label: "IPK",
              hint: "Contoh: 3.50",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.bachelorDegreeController,
              label: "Gelar",
              hint: "Contoh: S.Kom",
            ),
          ],

          // ── Pendidikan S2 ─────────────────────────────────────────────
          if (p.showEducationS2) ...[
            _buildHeading("S2"),
            _buildField(
              controller: p.masterUniversityController,
              label: "Nama Universitas",
              hint: "Masukkan nama universitas...",
            ),
            _buildField(
              controller: p.masterMajorController,
              label: "Jurusan",
              hint: "Masukkan jurusan...",
            ),
            _buildField(
              controller: p.masterStartYearController,
              label: "Tahun Masuk",
              hint: "Contoh: 2016",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.masterEndYearController,
              label: "Tahun Keluar",
              hint: "Contoh: 2018",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.masterGpaController,
              label: "IPK",
              hint: "Contoh: 3.70",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.masterDegreeController,
              label: "Gelar",
              hint: "Contoh: M.Kom",
            ),
          ],

          // ── Pendidikan S3 ─────────────────────────────────────────────
          if (p.showEducationS3) ...[
            _buildHeading("S3"),
            _buildField(
              controller: p.doctoralUniversityController,
              label: "Nama Universitas",
              hint: "Masukkan nama universitas...",
            ),
            _buildField(
              controller: p.doctoralMajorController,
              label: "Jurusan",
              hint: "Masukkan jurusan...",
            ),
            _buildField(
              controller: p.doctoralStartYearController,
              label: "Tahun Masuk",
              hint: "Contoh: 2018",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.doctoralEndYearController,
              label: "Tahun Keluar",
              hint: "Contoh: 2022",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.doctoralGpaController,
              label: "IPK",
              hint: "Contoh: 3.80",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.doctoralDegreeController,
              label: "Gelar",
              hint: "Contoh: Dr.",
            ),
          ],

          // ── Data Ayah ─────────────────────────────────────────────────
          if (p.showFamilyFather) ...[
            _buildHeading("Data Ayah"),
            _buildField(
              controller: p.fatherNameController,
              label: "Nama Ayah",
              hint: "Masukkan nama ayah...",
            ),
            _buildField(
              controller: p.fatherAgeController,
              label: "Umur Ayah",
              hint: "Masukkan umur ayah...",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.fatherEducationController,
              label: "Pendidikan Terakhir",
              hint: "SD / SMP / SMA / S1 / dll...",
            ),
            _buildField(
              controller: p.fatherJobTitleController,
              label: "Pekerjaan",
              hint: "Masukkan pekerjaan ayah...",
            ),
            _buildField(
              controller: p.fatherJobCompanyController,
              label: "Perusahaan",
              hint: "Masukkan perusahaan ayah...",
            ),
          ],

          // ── Data Ibu ──────────────────────────────────────────────────
          if (p.showFamilyMother) ...[
            _buildHeading("Data Ibu"),
            _buildField(
              controller: p.motherNameController,
              label: "Nama Ibu",
              hint: "Masukkan nama ibu...",
            ),
            _buildField(
              controller: p.motherAgeController,
              label: "Umur Ibu",
              hint: "Masukkan umur ibu...",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.motherEducationController,
              label: "Pendidikan Terakhir",
              hint: "SD / SMP / SMA / S1 / dll...",
            ),
            _buildField(
              controller: p.motherJobTitleController,
              label: "Pekerjaan",
              hint: "Masukkan pekerjaan ibu...",
            ),
            _buildField(
              controller: p.motherJobCompanyController,
              label: "Perusahaan",
              hint: "Masukkan perusahaan ibu...",
            ),
          ],

          // ── Data Pasangan ─────────────────────────────────────────────
          if (p.showFamilySpouse) ...[
            _buildHeading("Data Pasangan"),
            _buildField(
              controller: p.spouseController,
              label: "Nama Lengkap",
              hint: "Masukkan nama pasangan...",
            ),
            _buildField(
              controller: p.spouseAgeController,
              label: "Umur",
              hint: "Masukkan umur pasangan...",
              keyboardType: TextInputType.number,
            ),
            _buildField(
              controller: p.spouseEducationController,
              label: "Pendidikan Terakhir",
              hint: "SD / SMP / SMA / S1 / dll...",
            ),
          ],

          // Fallback: tampilkan pesan jika tidak ada section yang terdeteksi
          if (!p.showBiodataSection &&
              !p.showEducationSd &&
              !p.showEducationSmp &&
              !p.showEducationSma &&
              !p.showEducationS1 &&
              !p.showEducationS2 &&
              !p.showEducationS3 &&
              !p.showFamilyFather &&
              !p.showFamilyMother &&
              !p.showFamilySpouse &&
              !p.showSiblingSection &&
              !p.showChildrenSection &&
              p.status == RevisionStatus.loaded) ...[
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Tidak ada data yang perlu diperbaiki.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: label),
              const TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (maxLines > 1)
          TextFormField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.multiline,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )
        else
          CustomTextFormField(
            controller: controller,
            hintText: hint,
            keyboardType: keyboardType,
          ),
      ],
    );
  }
}
