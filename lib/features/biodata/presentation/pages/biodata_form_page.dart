import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_search_dropdown.dart';
import '../../domain/entities/region.dart';
import '../providers/biodata_form_provider.dart';
import '../widgets/custom_text_form_field.dart';

class BiodataFormPage extends StatefulWidget {
  const BiodataFormPage({super.key});

  @override
  State<BiodataFormPage> createState() => _BiodataFormPageState();
}

class _BiodataFormPageState extends State<BiodataFormPage> {
  @override
  void initState() {
    super.initState();
    context.read<BiodataFormProvider>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Formulir Data Diri'),
      body: Consumer<BiodataFormProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingData) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 90,
                ), // Spacing for header and bottom bar
                child: Form(
                  key: provider.formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          color: AppColors.third,
                          height: 20,
                          thickness: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomTextBiodata(
                                text: 'Informasi Pribadi',
                              ),
                              const CustomLabelBiodata(text: 'Nama Lengkap'),
                              CustomTextFormField(
                                controller: provider.nameController,
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Masukkan nama lengkap anda..',
                                prefKey: AppConstants.biodata.name,
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'Nama lengkap tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'Nama Panggilan'),
                              CustomTextFormField(
                                controller: provider.nicknameController,
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Masukkan nama panggilan anda..',
                                prefKey: AppConstants.biodata.nickname,
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'Nama panggilan tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'NIK KTP'),
                              CustomTextFormField(
                                keyboardType: TextInputType.number,
                                controller: provider.nikController,
                                hintText: 'Masukkan NIK anda..',
                                prefKey: AppConstants.biodata.nik,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'NIK tidak boleh kosong!';
                                  } else if (value.length != 16) {
                                    return 'NIK harus berjumlah 16 karakter!';
                                  }
                                  return null;
                                },
                              ),
                              const CustomTextBiodata(
                                text: 'Alamat sesuai KTP',
                              ),
                              const CustomLabelBiodata(
                                text: 'Provinsi Sesuai KTP',
                              ),
                              CustomSearchDropdown<Province>(
                                itemId: (item) => item.id,
                                itemFromId: (id) {
                                  return provider.provinces.firstWhere(
                                    (e) => e.id == id,
                                  );
                                },
                                prefKey: AppConstants.biodata.province,
                                hint: 'Pilih Provinsi',
                                items: provider.provinces,
                                itemAsString: (p0) => p0.name,
                                isLoading: false,
                                onChanged: (val) => provider.setProvince(val),
                                validator: (val) =>
                                    val == null ? 'Pilih Provinsi!' : null,
                              ),

                              const CustomLabelBiodata(
                                text: 'Kota/Kabupaten Sesuai KTP',
                              ),
                              CustomSearchDropdown<Regency>(
                                itemId: (item) => item.id,
                                itemFromId: (id) {
                                  return provider.regencies.firstWhere(
                                    (e) => e.id == id,
                                  );
                                },
                                prefKey: AppConstants.biodata.regency,
                                hint: 'Pilih Kota/Kabupaten',
                                items: provider.regencies,
                                itemAsString: (p0) => p0.name,
                                isLoading: provider.isLoadingRegency,
                                onChanged: (val) => provider.setRegency(val),
                                validator: (val) => val == null
                                    ? 'Pilih Kota/Kabupaten!'
                                    : null,
                              ),

                              const CustomLabelBiodata(
                                text: 'Kecamatan Sesuai KTP',
                              ),
                              CustomSearchDropdown<District>(
                                itemId: (item) => item.id,
                                itemFromId: (id) {
                                  return provider.districts.firstWhere(
                                    (e) => e.id == id,
                                  );
                                },
                                prefKey: AppConstants.biodata.district,
                                hint: 'Pilih Kecamatan',
                                items: provider.districts,
                                itemAsString: (p0) => p0.name,
                                isLoading: provider.isLoadingDistrict,
                                onChanged: (val) => provider.setDistrict(val),
                                validator: (val) =>
                                    val == null ? 'Pilih Kecamatan!' : null,
                              ),

                              const CustomLabelBiodata(
                                text: 'Kelurahan Sesuai KTP',
                              ),
                              CustomSearchDropdown<Village>(
                                itemId: (item) => item.id,
                                itemFromId: (id) {
                                  return provider.villages.firstWhere(
                                    (e) => e.id == id,
                                  );
                                },
                                prefKey: AppConstants.biodata.village,
                                hint: 'Pilih Kelurahan',
                                items: provider.villages,
                                itemAsString: (p0) => p0.name,
                                isLoading: provider.isLoadingVillage,
                                onChanged: (val) => provider.setVillage(val),
                                validator: (val) =>
                                    val == null ? 'Pilih Kelurahan!' : null,
                              ),

                              const CustomLabelBiodata(text: 'Kode Pos'),
                              CustomTextFormField(
                                keyboardType: TextInputType.number,
                                controller: provider.postalCodeController,
                                hintText: 'Masukkan kode pos..',
                                prefKey: AppConstants.biodata.postalCode,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(8),
                                ],
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'Kode pos tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'Alamat'),
                              CustomTextFormField(
                                controller: provider.addressController,
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Masukkan alamat sesuai KTP anda',
                                prefKey: AppConstants.biodata.address,
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'Alamat tidak boleh kosong !'
                                    : null,
                              ),

                              const CustomTextBiodata(text: 'Alamat saat ini'),
                              Row(
                                children: [
                                  const Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'Alamat saat ini sama dengan KTP',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 2 / 3,
                                    child: Switch(
                                      value: provider.isSwitchOn,
                                      activeTrackColor: AppColors.primary
                                          .withOpacity(0.5),
                                      onChanged: provider.toggleSwitch,
                                      inactiveThumbColor: Colors.grey,
                                      activeColor: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),

                              if (!provider.isSwitchOn) ...[
                                const CustomLabelBiodata(
                                  text: 'Provinsi Domisili',
                                ),
                                CustomSearchDropdown<Province>(
                                  itemId: (item) => item.id,
                                  itemFromId: (id) {
                                    return provider.provincesDom.firstWhere(
                                      (e) => e.id == id,
                                    );
                                  },
                                  prefKey: AppConstants.biodata.currentProvince,
                                  hint: 'Pilih Provinsi',
                                  items: provider.provincesDom,
                                  itemAsString: (p0) => p0.name,
                                  isLoading: false,
                                  onChanged: (val) =>
                                      provider.setProvinceDom(val),
                                  validator: (val) =>
                                      val == null ? 'Pilih Provinsi!' : null,
                                ),

                                const CustomLabelBiodata(
                                  text: 'Kota/Kabupaten Domisili',
                                ),
                                CustomSearchDropdown<Regency>(
                                  itemId: (item) => item.id,
                                  itemFromId: (id) {
                                    return provider.regenciesDom.firstWhere(
                                      (e) => e.id == id,
                                    );
                                  },
                                  prefKey: AppConstants.biodata.currentRegency,
                                  hint: 'Pilih Kota/Kabupaten',
                                  items: provider.regenciesDom,
                                  itemAsString: (p0) => p0.name,
                                  isLoading: provider.isLoadingRegencyDom,
                                  onChanged: (val) =>
                                      provider.setRegencyDom(val),
                                  validator: (val) => val == null
                                      ? 'Pilih Kota/Kabupaten!'
                                      : null,
                                ),

                                const CustomLabelBiodata(
                                  text: 'Kecamatan Domisili',
                                ),
                                CustomSearchDropdown<District>(
                                  itemId: (item) => item.id,
                                  itemFromId: (id) {
                                    return provider.districtsDom.firstWhere(
                                      (e) => e.id == id,
                                    );
                                  },
                                  prefKey: AppConstants.biodata.currentDistrict,
                                  hint: 'Pilih Kecamatan',
                                  items: provider.districtsDom,
                                  itemAsString: (p0) => p0.name,
                                  isLoading: provider.isLoadingDistrictDom,
                                  onChanged: (val) =>
                                      provider.setDistrictDom(val),
                                  validator: (val) =>
                                      val == null ? 'Pilih Kecamatan!' : null,
                                ),

                                const CustomLabelBiodata(
                                  text: 'Kelurahan Domisili',
                                ),
                                CustomSearchDropdown<Village>(
                                  itemId: (item) => item.id,
                                  itemFromId: (id) {
                                    return provider.villagesDom.firstWhere(
                                      (e) => e.id == id,
                                    );
                                  },
                                  prefKey: AppConstants.biodata.currentVillage,
                                  hint: 'Pilih Kelurahan',
                                  items: provider.villagesDom,
                                  itemAsString: (p0) => p0.name,
                                  isLoading: provider.isLoadingVillageDom,
                                  onChanged: (val) =>
                                      provider.setVillageDom(val),
                                  validator: (val) =>
                                      val == null ? 'Pilih Kelurahan!' : null,
                                ),

                                const CustomLabelBiodata(text: 'Kode Pos'),
                                CustomTextFormField(
                                  controller: provider.postalCodeDomController,
                                  keyboardType: TextInputType.number,
                                  hintText: 'Masukkan kode pos domisili..',
                                  prefKey:
                                      AppConstants.biodata.currentPostalCode,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(8),
                                  ],
                                  validator: (value) =>
                                      (value == null || value.isEmpty)
                                      ? 'Kode pos tidak boleh kosong'
                                      : null,
                                ),
                                const CustomLabelBiodata(text: 'Alamat'),
                                CustomTextFormField(
                                  controller: provider.addressDomController,
                                  textCapitalization: TextCapitalization.words,
                                  hintText:
                                      'Masukkan alamat jalan domisili anda..',
                                  prefKey: AppConstants.biodata.currentAddress,
                                  validator: (value) =>
                                      (value == null || value.isEmpty)
                                      ? 'Alamat domisili tidak boleh kosong'
                                      : null,
                                ),
                              ],

                              const CustomTextBiodata(text: 'Umum'),
                              const CustomLabelBiodata(
                                text: 'Status Tempat Tinggal',
                              ),
                              _buildDropdown(
                                context,
                                value: provider.selectedResidenceStatus,
                                items: provider.itemsMapAddress,
                                label: 'Pilih Status Tempat Tinggal..',
                                onChanged: (val) =>
                                    provider.setResidenceStatus(val),
                                errorText:
                                    'Status Tempat tinggal tidak boleh kosong !',
                                isMap: true,
                              ),

                              const CustomLabelBiodata(text: 'No Handphone'),
                              CustomTextFormField(
                                keyboardType: TextInputType.number,
                                controller: provider.phoneController,
                                hintText: 'Masukkan no handphone..',
                                prefKey: AppConstants.biodata.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'No hp tidak boleh kosong !'
                                    : null,
                              ),

                              const CustomLabelBiodata(text: 'Kontak Darurat'),
                              CustomTextFormField(
                                controller: provider.emergencyPhoneController,
                                keyboardType: TextInputType.number,
                                hintText: 'Masukkan kontak darurat..',
                                prefKey: AppConstants.biodata.emergencyContact,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'Kontak tidak boleh kosong !'
                                    : null,
                              ),

                              const CustomLabelBiodata(text: 'Jenis Kelamin'),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Laki-laki'),
                                      contentPadding: EdgeInsets.zero,
                                      leading: Radio<String>(
                                        activeColor: AppColors.primary,
                                        value: "L",
                                        groupValue: provider.selectedGender,
                                        onChanged: (val) =>
                                            provider.setGender(val!),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Perempuan'),
                                      contentPadding: EdgeInsets.zero,
                                      leading: Radio<String>(
                                        activeColor: AppColors.primary,
                                        value: "P",
                                        groupValue: provider.selectedGender,
                                        onChanged: (val) =>
                                            provider.setGender(val!),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (provider.genderError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    left: 12,
                                  ),
                                  child: Text(
                                    provider.genderError!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                              const CustomLabelBiodata(text: 'Tempat Lahir'),
                              CustomTextFormField(
                                controller: provider.birthPlaceController,
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Masukkan Tempat Lahir Anda.. ',
                                prefKey: AppConstants.biodata.birthPlace,
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                    ? 'Tempat lahir tidak boleh kosong !'
                                    : null,
                              ),

                              const CustomLabelBiodata(text: 'Tanggal Lahir'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: InkWell(
                                  onTap: () =>
                                      provider.selectBirthDate(context),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: provider.birthDateController,
                                      readOnly: true,
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                          ? 'Tanggal Lahir tidak boleh kosong !'
                                          : null,
                                      decoration: InputDecoration(
                                        hintText: 'Pilih Tanggal Lahir..',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const CustomLabelBiodata(text: 'Agama'),
                              _buildDropdown(
                                context,
                                value: provider.selectedReligion,
                                items: provider.itemsMapReligi,
                                label: 'Pilih Agama..',
                                onChanged: (val) => provider.setReligion(val),
                                errorText: 'Agama tidak boleh kosong !',
                                isMap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const HeaderScroll(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 0,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final provider = context.read<BiodataFormProvider>();
                  final isValid = await provider.submit();

                  // Only navigate if form validation passes
                  if (isValid && context.mounted) {
                    context.pushNamed(RouteNames.educationForm);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selanjutnya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String? value,
    required Map<String, String> items,
    required String label,
    required Function(String?) onChanged,
    required String errorText,
    bool enabled = true,
    bool isMap = false, // If true, map keys are values, else keys are IDs
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        items: items.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        validator: (val) => (val == null || val.isEmpty) ? errorText : null,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        menuMaxHeight: 200.0,
      ),
    );
  }
}

// Custom Widgets ported from v1 or recreated
class CustomLabelBiodata extends StatelessWidget {
  final String text;
  const CustomLabelBiodata({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}

class CustomTextBiodata extends StatelessWidget {
  final String text;
  const CustomTextBiodata({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class HeaderScroll extends StatelessWidget {
  const HeaderScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _checkContract(isActive: true, number: 1, title: "Biodata"),
                _checkContract(number: 2, title: "Riwayat Pendidikan"),
                _checkContract(number: 3, title: "Data Keluarga"),
                _checkContract(number: 4, title: "Kelengkapan Dokumen"),
                _checkContract(number: 5, title: "Keahlian"),
                _checkContract(number: 6, title: "Ambil Foto Selfie"),
                _checkContract(
                  number: 7,
                  title: "Ambil Foto Selfie dengan KTP",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkContract({
    required int number,
    required String title,
    bool isActive = false,
  }) {
    return Row(
      children: [
        if (number != 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 40,
              height: 3,
              color: isActive ? const Color(0xffFDE0D1) : AppColors.secondary,
            ),
          ),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.white,
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.secondary,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? AppColors.primary : AppColors.secondary,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
