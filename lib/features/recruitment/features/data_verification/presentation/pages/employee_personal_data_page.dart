import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_search_dropdown.dart';
import 'package:maha_apps_v2/shared/widgets/custom_text_form_field.dart';

class EmployeePersonalDataPage extends StatefulWidget {
  const EmployeePersonalDataPage({super.key, required this.id});
  final int id;

  @override
  State<EmployeePersonalDataPage> createState() =>
      _EmployeePersonalDataPageState();
}

class _EmployeePersonalDataPageState extends State<EmployeePersonalDataPage> {
  final _startWorkController = TextEditingController();
  final _gajiController = TextEditingController();
  final _gajiPokokController = TextEditingController();
  final _tunjanganTransportasiController = TextEditingController();
  final _tunjanganMakanController = TextEditingController();
  final _tunjanganPulsaController = TextEditingController();
  final _tunjanganIstriController = TextEditingController();
  final _tunjanganAnakController = TextEditingController();
  final _tunjanganJabatanController = TextEditingController();
  final _tunjanganLuarKotaController = TextEditingController();
  final _pajakPenghasilanController = TextEditingController();
  final _totalGajiController = TextEditingController();

  final List<TextEditingController> _jobdeskControllers = [
    TextEditingController(),
  ];

  DateTime? _startWork;
  bool _isEditing = false;

  void _applyRevision() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: _RevisionDescriptionSheet(),
        );
      },
    );
  }

  void _pickStartWorkDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red, // header + selected date
              onPrimary: Colors.white, // text on red
              onSurface: Colors.black, // body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // OK / CANCEL
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      _startWork = date;
      _startWorkController.text = DateFormat("dd/MM/yyyy").format(date);
    }
  }

  void _addJobdesk() {
    setState(() => _jobdeskControllers.add(TextEditingController()));
  }

  @override
  void dispose() {
    super.dispose();
    _startWorkController.dispose();
    _gajiController.dispose();
    _gajiPokokController.dispose();
    _tunjanganTransportasiController.dispose();
    _tunjanganMakanController.dispose();
    _tunjanganPulsaController.dispose();
    _tunjanganIstriController.dispose();
    _tunjanganAnakController.dispose();
    _tunjanganJabatanController.dispose();

    for (var controller in _jobdeskControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Data Diri"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 24),
            Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12),

            //-----------/ Data Karyawan /-----------//
            _buildSectionHeader(
              assetIcon: "assets/images/icon/ic_id_card_filled.svg",
              title: "Data Karyawan",
            ),
            _buildField(
              label: "Nama Lengkap",
              value: "Agatha Rachmawan P",
            ),
            _buildField(
              label: "Nama Panggilan",
              value: "Gentong",
            ),
            _buildField(
              label: "Email",
              value: "demo@mahasejahtera.com",
            ),
            _buildField(label: "Jabatan"),
            _buildField(label: "Divisi"),
            _buildField(label: "Cabang"),
            _buildField(label: "Gaji"),
            _buildField(
              label: "NIK",
              value: "147104102310000001",
            ),
            _buildField(
              label: "Alamat",
              value: "Jl. Usaha Gg. Usaha No.08",
            ),
            _buildField(
              label: "Alamat Domisili",
              value: "Jl. Eka Surya No.48 Medan Johor",
            ),
            _buildField(
              label: "Status Tempat Tinggal",
              value: "Kost",
            ),
            _buildField(
              label: "No. Telephone/HP",
              value: "+6281277746448",
            ),
            _buildField(
              label: "No. Telephone Darurat",
              value: "+6281277746448",
            ),
            _buildField(
              label: "Jenis Kelamin",
              value: "Laki-laki",
            ),
            _buildField(
              label: "Tempat Tanggal Lahir",
              value: "Pekanbaru, 23 Oktober 2000",
            ),
            _buildField(
              label: "Agama",
              value: "Islam",
            ),
            _buildField(
              label: "Status Perkawinan",
              value: "Kawin",
            ),
            _buildField(
              label: "Tahun Menikah",
              value: "2017",
            ),

            //-----------/ Pendidikan /-----------//
            _buildSectionHeader(
              assetIcon: "assets/images/icon/ic_user_graduate.svg",
              title: "Pendidikan",
            ),
            _buildSubHeading("SMK"),
            _buildField(
              label: "Nama Sekolah - SMK",
              value: "SMAN 2 Bojonegoro",
            ),
            _buildField(
              label: "Tahun Masuk",
              value: "2018 s/d 2021",
            ),

            _buildSubHeading("DLL"),
            _buildField(
              label: "Perguruan Tinggi - DIII",
              value: "Universitas Brawijaya",
            ),
            _buildField(
              label: "Jurusan",
              value: "Sistem Informasi",
            ),
            _buildField(
              label: "Tahun Masuk - Selesai",
              value: "2021 s/d 2024",
            ),
            _buildField(
              label: "IPK",
              value: "3.74",
            ),
            _buildField(
              label: "Gelar",
              value: "A.Md.Kom",
            ),

            //-----------/ Data Keluarga /-----------//
            _buildSectionHeader(
              assetIcon: "assets/images/icon/dokumen.svg",
              title: "Data Keluarga",
              iconSize: 16,
            ),
            _buildSubHeading("Ayah"),
            _buildField(
              label: "Nama Lengkap",
              value: "Wito",
            ),
            _buildField(
              label: "Usia",
              value: "50",
            ),
            _buildField(
              label: "Status",
              value: "Masih Hidup",
            ),
            _buildField(
              label: "Pendidikan Terakhir",
              value: "SMA",
            ),
            _buildField(
              label: "Pekerjaan",
              value: "Jendral",
            ),
            _buildField(
              label: "Perusahaan Pekerjaan Terakhir",
              value: "Armada X 5 Rombongan Nyeni",
            ),

            _buildSubHeading("Ibu"),
            _buildField(
              label: "Nama Lengkap",
              value: "Ica Celo",
            ),
            _buildField(
              label: "Usia",
              value: "45",
            ),
            _buildField(
              label: "Status",
              value: "Masih Hidup",
            ),
            _buildField(
              label: "Pendidikan Terakhir",
              value: "SMP",
            ),
            _buildField(
              label: "Pekerjaan",
              value: "Joget Sound Horeg",
            ),
            _buildField(
              label: "Perusahaan Pekerjaan Terakhir",
              value: "Sound Horeg Cumi-cumi",
            ),

            _buildSubHeading("Saudara Ke-1"),
            _buildField(
              label: "Nama Lengkap",
              value: "Yanto Kaset",
            ),
            _buildField(
              label: "Usia",
              value: "25",
            ),
            _buildField(
              label: "Status",
              value: "Masih Hidup",
            ),
            _buildField(
              label: "Pendidikan Terakhir",
              value: "SMK",
            ),
            _buildField(
              label: "Pekerjaan",
              value: "Bisnis Wirausaha",
            ),
            _buildField(label: "Perusahaan Pekerjaan Terakhir"),

            //-----------/ Dokumen /-----------//
            _buildSectionHeader(
              assetIcon: "assets/images/icon/dokumen_icon.svg",
              title: "Dokumen",
            ),
            _buildDocumentField(
              label: "Pas Photo",
              date: DateTime(2024, 4, 29),
              photoUrl: "",
            ),
            _buildDocumentField(
              label: "KTP",
              date: DateTime(2024, 4, 29),
              photoUrl: "",
            ),
            _buildDocumentField(
              label: "Kartu Keluarga",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "Buku Rekening",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "Ijazah",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "Transkrip Nilai",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "NPWP",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "BPJS Ketenagakerjaan",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "BPJS Kesehatan",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),
            _buildDocumentField(
              label: "Sertifikat Keahlian",
              date: DateTime(2024, 4, 29),
              isFile: true,
            ),

            //-----------/ Keahlian /-----------//
            _buildSectionHeader(
              assetIcon: "assets/images/icon_keahlian_icon.svg",
              title: "Keahlian",
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                _buildSkill("UI/UX Designer"),
                _buildSkill("UI Desginer"),
                _buildSkill("UX Researcher"),
              ],
            ),

            //-----------/ Inputs /-----------//
            SizedBox(height: 32),
            _buildLabel("Status Karyawan"),
            CustomSearchDropdown(
              hint: "Pilih status karyawan disini...",
              items: [],
              onChanged: (value) {},
              itemAsString: (p0) => p0.toString(),
              itemFromId: (id) => id,
              itemId: (item) => item,
            ),

            _buildLabel("Penempatan"),
            CustomSearchDropdown(
              hint: "Pilih lokasi kerja Anda disini...",
              items: [],
              onChanged: (value) {},
              itemAsString: (p0) => p0.toString(),
              itemFromId: (id) => id,
              itemId: (item) => item,
            ),

            _buildLabel("Pilih Jam Kerja"),
            CustomSearchDropdown(
              hint: "Pilih jam kerja Anda disini...",
              items: [],
              onChanged: (value) {},
              itemAsString: (p0) => p0.toString(),
              itemFromId: (id) => id,
              itemId: (item) => item,
            ),

            _buildLabel("Departemen"),
            CustomSearchDropdown(
              hint: "Pilih departemen Anda disini...",
              items: [],
              onChanged: (value) {},
              itemAsString: (p0) => p0.toString(),
              itemFromId: (id) => id,
              itemId: (item) => item,
            ),

            _buildLabel("Jabatan"),
            CustomSearchDropdown(
              hint: "Pilih jabatan Anda disini...",
              items: [],
              onChanged: (value) {},
              itemAsString: (p0) => p0.toString(),
              itemFromId: (id) => id,
              itemId: (item) => item,
            ),

            _buildLabel("Mulai Bekerja"),
            TextField(
              controller: _startWorkController,
              readOnly: true,
              onTap: _pickStartWorkDate,
              decoration: InputDecoration(
                hintText: "dd/mm/yyyy",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                ),
                border: _buildTextFieldBorder(),
                enabledBorder: _buildTextFieldBorder(),
                focusedBorder: _buildTextFieldBorder(),
                errorBorder: _buildTextFieldBorder(),
                focusedErrorBorder: _buildTextFieldBorder(),
              ),
            ),

            _buildLabel("Jobdesk"),
            ...List.generate(_jobdeskControllers.length, (index) {
              final controller = _jobdeskControllers[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  minLines: 2,
                  decoration: InputDecoration(
                    hintText: "Tuliskan jobdesk calon karyawan disini...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: _buildTextFieldBorder(),
                    enabledBorder: _buildTextFieldBorder(),
                    focusedBorder: _buildTextFieldBorder(),
                    errorBorder: _buildTextFieldBorder(),
                    focusedErrorBorder: _buildTextFieldBorder(),
                  ),
                ),
              );
            }),
            CustomOutlinedButton.add(
              onPressed: _addJobdesk,
              child: Text("Tambah Jobdesk"),
            ),

            //-----------/ Kompensasi /-----------//
            _buildLabel("Kompensasi", isRequired: true),
            _RpTextFormField(
              controller: _gajiController,
              label: "Gaji",
              emptyLabel: "Gaji tidak boleh kosong",
            ),
            _RpTextFormField(
              controller: _gajiPokokController,
              label: "Gaji Pokok",
              enabled: false,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tunjangan Tetap",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 12),
            _RpTextFormField(
              controller: _tunjanganTransportasiController,
              label: "Tunjangan Transportasi",
              enabled: false,
            ),
            _RpTextFormField(
              controller: _tunjanganMakanController,
              label: "Tunjangan Makan",
              enabled: false,
            ),
            _RpTextFormField(
              controller: _tunjanganPulsaController,
              label: "Tunjangan Pulsa",
              enabled: false,
            ),
            _RpTextFormField(
              controller: _tunjanganIstriController,
              label: "Tunjangan Istri",
              enabled: false,
              help:
                  "Tunjangan Istri akan otomatis mendapatkan apabila sudah bekerja selama 24 bulan atau 2 tahun.",
            ),
            _RpTextFormField(
              controller: _tunjanganAnakController,
              label: "Tunjangan Anak",
              enabled: false,
              help:
                  "Tunjangan Anak akan otomatis mendapatkan apabila sudah bekerja selama 24 bulan atau 2 tahun. Maksimal 2 anak.",
            ),
            _RpTextFormField(
              controller: _tunjanganJabatanController,
              label: "Tunjangan Jabatan (Opsional)",
              isRequired: false,
            ),
            // TODO: onpressed
            CustomOutlinedButton.add(
              onPressed: () {},
              child: Text("Tunjangan Tetap"),
            ),

            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tunjangan Tidak Tetap",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8),
            _CustomCheckbox(label: "Tunjangan Uang Makan Luar Kota (opsional)"),
            SizedBox(height: 12),
            _RpTextFormField(
              controller: _tunjanganLuarKotaController,
              label: "Tunjangan Tinggal Luar Kota (opsional)",
              isRequired: false,
            ),
            // TODO: onpressed
            CustomOutlinedButton.add(
              onPressed: () {},
              child: Text("Tunjangan Tidak Tetap"),
            ),

            //-----------/ Fasilitas /-----------//
            _buildLabel("Fasilitas", isRequired: true),
            _CustomCheckbox(label: "BPJS Kesehatan"),
            _CustomCheckbox(label: "BPJS TK (JKN)"),
            _CustomCheckbox(label: "BPJS TK (JKK)"),
            _CustomCheckbox(label: "BPJS TK (HT)"),
            _CustomCheckbox(label: "BPJS TK (JP)"),
            // TODO: onpressed
            CustomOutlinedButton.add(
              onPressed: () {},
              child: Text("Tambah Fasilitas"),
            ),

            //-----------/ Pajak /-----------//
            _buildLabel("Pajak", isRequired: true),
            CustomTextFormField(
              controller: _pajakPenghasilanController,
              hintText: "Pajak Penghasilan",
            ),
            SizedBox(height: 12),
            CustomOutlinedButton.add(
              onPressed: () {},
              child: Text("Tambah Pajak"),
            ),
            SizedBox(height: 12),
            _RpTextFormField(
              controller: _totalGajiController,
              label: "Total Gaji",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: _buildBottomButtons(),
      ),
    );
  }

  Widget _buildBottomButtons() {
    if (_isEditing) {
      return Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () => setState(() => _isEditing = false),
              color: AppColors.blue,
              child: Text("Batal"),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: CustomElevatedButton(
              onPressed: _applyRevision,
              color: AppColors.blue,
              child: Text("Revisi"),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            onPressed: () => setState(() => _isEditing = true),
            color: AppColors.blue,
            child: Text("Revisi"),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CustomElevatedButton(
            onPressed: () => context.push(AppRoutes.createEmploymentAgreement.path),
            loading: false,
            child: Text("Terima"),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String assetIcon,
    required String title,
    double iconSize = 24,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(40),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                assetIcon,
                height: iconSize,
                width: iconSize,
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade800,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => setState(() => _isEditing = !_isEditing),
              style: IconButton.styleFrom(
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(8),
                iconSize: 24,
              ),
              icon: Icon(
                Icons.edit_note,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildField({required String label, String? value}) {
    return _DataField(
      isEditing: _isEditing,
      label: label,
      value: value,
    );
  }

  Widget _buildDocumentField({
    required String label,
    DateTime? date,
    String? photoUrl,
    bool isFile = false,
  }) {
    final dateString = date == null
        ? "-"
        : DateFormat("dd/MM/yyyy").format(date);

    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            if (isFile)
              SvgPicture.asset(
                "assets/images/icon/logo_pdf.svg",
                height: 48,
                width: 48,
              ),
            if (photoUrl != null)
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upload $dateString",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkill(String skill) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
              ),
              if (isRequired)
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  InputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}

class _RpTextFormField extends StatelessWidget {
  const _RpTextFormField({
    required this.controller,
    required this.label,
    this.emptyLabel,
    this.enabled = true,
    this.isRequired = true,
    this.help,
  });

  final TextEditingController controller;
  final String label;
  final String? emptyLabel;
  final bool enabled;
  final bool isRequired;
  final String? help;

  String? _emptyValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return emptyLabel ?? "$label tidak boleh kosong";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextFormField(
          enabled: enabled,
          controller: controller,
          validator: isRequired ? _emptyValidator : null,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: !enabled,
            fillColor: Colors.grey.shade200,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 4),
              child: Text(
                "Rp.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (help != null) ...[
          SizedBox(height: 8),
          Text(
            help!,
            style: TextStyle(
              color: AppColors.blue,
              fontSize: 12,
            ),
          ),
        ],
        SizedBox(height: 12),
      ],
    );
  }
}

class _CustomCheckbox extends StatefulWidget {
  const _CustomCheckbox({required this.label});
  final String label;

  @override
  State<_CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<_CustomCheckbox> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(widget.label),
        ),
        Checkbox(
          value: _checked,
          onChanged: (value) => setState(() => _checked = !_checked),
        ),
      ],
    );
  }
}

class _DataField extends StatefulWidget {
  const _DataField({
    required this.isEditing,
    required this.label,
    this.value,
  });

  final String label;
  final String? value;
  final bool isEditing;

  @override
  State<_DataField> createState() => _DataFieldState();
}

class _DataFieldState extends State<_DataField> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                ),
                SizedBox(height: 4),
                Text(
                  widget.value ?? "-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          if (widget.isEditing)
            Checkbox(
              value: _selected,
              onChanged: (value) => setState(() => _selected = !_selected),
            ),
        ],
      ),
    );
  }
}

class _RevisionDescriptionSheet extends StatefulWidget {
  const _RevisionDescriptionSheet();

  @override
  State<_RevisionDescriptionSheet> createState() =>
      _RevisionDescriptionSheetState();
}

class _RevisionDescriptionSheetState extends State<_RevisionDescriptionSheet> {
  final _descriptionController = TextEditingController();
  bool _valid = false;

  void _validate() {
    bool valid = _descriptionController.text.isNotEmpty;
    if (_valid != valid) setState(() => _valid = valid);
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Keterangan Direvisi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 5,
              onChanged: (value) => _validate(),
              decoration: InputDecoration(
                hintText: "Masukkan keterangan revisi...",
                enabledBorder: _buildBorder(),
                focusedBorder: _buildBorder(),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () {
                  context.pop();
                  context.pop();
                },
                loading: !_valid,
                child: Text("Tolak"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
