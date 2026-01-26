import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/family_provider.dart';
import 'biodata_form_page.dart' show CustomLabelBiodata, CustomTextBiodata, CustomTextFormField;

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Formulir Data Diri'),
      body: Consumer<FamilyProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingData) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 50, bottom: 90),
                child: Form(
                  key: provider.formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(color: AppColors.third, height: 20, thickness: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomTextBiodata(text: 'Data Orang Tua'),

                              // --- FATHER SECTION ---
                              const CustomLabelBiodata(text: 'Nama Ayah'),
                              CustomTextFormField(
                                controller: provider.fatherNameController,
                                hintText: 'Masukkan nama ayah..',
                                validator: (value) => (value == null || value.isEmpty)
                                    ? 'Nama tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'Status'),
                              _buildDropdown(
                                context,
                                value: provider.lifeFatherOption,
                                items: provider.itemsMapLife.map(
                                  (k, v) => MapEntry(k.toString(), v),
                                ),
                                label: 'Pilih Status..',
                                onChanged: (val) => provider.setLifeFatherOption(val),
                                errorText: 'Status tidak boleh kosong !',
                              ),
                              const CustomLabelBiodata(text: 'Usia'),
                              CustomTextFormField(
                                controller: provider.fatherAgeController,
                                hintText: 'Masukkan usia ayah..',
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                validator: (value) => (value == null || value.isEmpty)
                                    ? 'Usia tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'Pendidikan Terakhir'),
                              _buildDropdown(
                                context,
                                value: provider.lastEducationFatherOption,
                                items: provider.itemsEducation,
                                label: 'Pilih pendidikan..',
                                onChanged: (val) => provider.setLastEducationFatherOption(val),
                                errorText: 'Pendidikan tidak boleh kosong !',
                              ),
                              const CustomLabelBiodata(text: 'Pekerjaan Terakhir (Opsional)'),
                              CustomTextFormField(
                                controller: provider.fatherJobController,
                                hintText: 'Masukkan pekerjaan..',
                              ),
                              const CustomLabelBiodata(text: 'Nama Perusahaan (Opsional)'),
                              CustomTextFormField(
                                controller: provider.fatherCompanyController,
                                hintText: 'Masukkan nama perusahaan..',
                              ),

                              const SizedBox(height: 20),

                              // --- MOTHER SECTION ---
                              const CustomLabelBiodata(text: 'Nama Ibu'),
                              CustomTextFormField(
                                controller: provider.motherNameController,
                                hintText: 'Masukkan nama ibu..',
                                validator: (value) => (value == null || value.isEmpty)
                                    ? 'Nama tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'Status'),
                              _buildDropdown(
                                context,
                                value: provider.lifeMotherOption,
                                items: provider.itemsMapLife.map(
                                  (k, v) => MapEntry(k.toString(), v),
                                ),
                                label: 'Pilih Status..',
                                onChanged: (val) => provider.setLifeMotherOption(val),
                                errorText: 'Status tidak boleh kosong !',
                              ),
                              const CustomLabelBiodata(text: 'Usia'),
                              CustomTextFormField(
                                controller: provider.motherAgeController,
                                hintText: 'Masukkan usia ibu..',
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                validator: (value) => (value == null || value.isEmpty)
                                    ? 'Usia tidak boleh kosong !'
                                    : null,
                              ),
                              const CustomLabelBiodata(text: 'Pendidikan Terakhir'),
                              _buildDropdown(
                                context,
                                value: provider.lastEducationMotherOption,
                                items: provider.itemsEducation,
                                label: 'Pilih pendidikan..',
                                onChanged: (val) => provider.setLastEducationMotherOption(val),
                                errorText: 'Pendidikan tidak boleh kosong !',
                              ),
                              const CustomLabelBiodata(text: 'Pekerjaan Terakhir (Opsional)'),
                              CustomTextFormField(
                                controller: provider.motherJobController,
                                hintText: 'Masukkan pekerjaan..',
                              ),
                              const CustomLabelBiodata(text: 'Nama Perusahaan (Opsional)'),
                              CustomTextFormField(
                                controller: provider.motherCompanyController,
                                hintText: 'Masukkan nama perusahaan..',
                              ),

                              const SizedBox(height: 10),

                              // --- SIBLINGS SECTION ---
                              Divider(color: Colors.grey[200]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomTextBiodata(text: 'Data Saudara'),
                                  TextButton.icon(
                                    onPressed: provider.addSibling,
                                    icon: const Icon(Icons.add, size: 16, color: AppColors.primary),
                                    label: const Text(
                                      'Tambah',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.nameSiblingControllers.length,
                                itemBuilder: (context, index) {
                                  return _buildSiblingForm(context, provider, index);
                                },
                              ),

                              const SizedBox(height: 10),

                              // --- MARRIED STATUS SECTION ---
                              Divider(color: Colors.grey[200]),
                              const CustomTextBiodata(text: 'Status Pernikahan'),
                              _buildDropdown(
                                context,
                                value: provider.statusMarriedOption,
                                items: provider.statusMarriedMap,
                                label: 'Pilih Status Pernikahan',
                                onChanged: (val) => provider.setStatusMarriedOption(val),
                                errorText: 'Status pernikahan wajib diisi',
                              ),

                              if (provider.statusMarriedOption == 'kawin') ...[
                                const CustomTextBiodata(text: 'Suami/Istri'),
                                const CustomLabelBiodata(text: 'Nama Lengkap'),
                                CustomTextFormField(
                                  controller: provider.coupleNameController,
                                  hintText: 'Masukkan nama lengkap..',
                                  validator: (value) => (value == null || value.isEmpty)
                                      ? 'Nama tidak boleh kosong !'
                                      : null,
                                ),
                                const CustomLabelBiodata(text: 'Usia'),
                                CustomTextFormField(
                                  controller: provider.coupleAgeController,
                                  hintText: 'Masukkan usia..',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (value) => (value == null || value.isEmpty)
                                      ? 'Usia tidak boleh kosong !'
                                      : null,
                                ),
                                const CustomLabelBiodata(text: 'Pendidikan Terakhir'),
                                _buildDropdown(
                                  context,
                                  value: provider.coupleEducationOption,
                                  items: provider.itemsEducation,
                                  label: 'Pilih pendidikan..',
                                  onChanged: (val) => provider.setCoupleEducationOption(val),
                                  errorText: 'Pendidikan tidak boleh kosong !',
                                ),
                                const CustomLabelBiodata(text: 'Pekerjaan Terakhir (Opsional)'),
                                CustomTextFormField(
                                  controller: provider.coupleJobController,
                                  hintText: 'Masukkan pekerjaan..',
                                ),
                                const CustomLabelBiodata(text: 'Nama Perusahaan (Opsional)'),
                                CustomTextFormField(
                                  controller: provider.coupleCompanyController,
                                  hintText: 'Masukkan nama perusahaan..',
                                ),

                                // --- CHILDREN SECTION ---
                                const SizedBox(height: 10),
                                const CustomLabelBiodata(text: 'Apakah Memiliki Anak?'),
                                _buildDropdown(
                                  context,
                                  value: provider.statusChildOption,
                                  items: provider.statusChildMap,
                                  label: 'Pilih..',
                                  onChanged: (val) => provider.setStatusChildOption(val),
                                  errorText: 'Pilih salah satu!',
                                ),

                                if (provider.statusChildOption == '2') ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomTextBiodata(text: 'Data Anak'),
                                      TextButton.icon(
                                        onPressed: provider.addChildren,
                                        icon: const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: AppColors.primary,
                                        ),
                                        label: const Text(
                                          'Tambah',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: provider.nameChildrenControllers.length,
                                    itemBuilder: (context, index) {
                                      return _buildChildrenForm(context, provider, index);
                                    },
                                  ),
                                ],
                              ],

                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const HeaderScrollFamily(),
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
              child: OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<FamilyProvider>().submit();
                  if (context.mounted) {
                    context.pushNamed(RouteNames.documentForm);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                    Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDropdown(
    BuildContext context, {
    required String? value,
    required Map<String, String> items,
    required String label,
    required Function(String?) onChanged,
    required String errorText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        items: items.entries.map((entry) {
          return DropdownMenuItem<String>(value: entry.key, child: Text(entry.value));
        }).toList(),
        onChanged: onChanged,
        validator: (val) => (val == null || val.isEmpty) ? errorText : null,
        decoration: InputDecoration(
          labelText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        menuMaxHeight: 200.0,
      ),
    );
  }

  Widget _buildSiblingForm(BuildContext context, FamilyProvider provider, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saudara ke-${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => provider.removeSibling(index),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const CustomLabelBiodata(text: 'Nama Lengkap'),
            CustomTextFormField(
              controller: provider.nameSiblingControllers[index],
              hintText: 'Nama saudara..',
              validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
            const CustomLabelBiodata(text: 'Jenis Kelamin'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Laki-laki', style: TextStyle(fontSize: 14)),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'L',
                      groupValue: provider.genderSiblingControllers[index],
                      onChanged: (val) => provider.setSiblingGender(index, val!),
                      activeColor: AppColors.primary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Perempuan', style: TextStyle(fontSize: 14)),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'P',
                      groupValue: provider.genderSiblingControllers[index],
                      onChanged: (val) => provider.setSiblingGender(index, val!),
                      activeColor: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const CustomLabelBiodata(text: 'Usia'),
            CustomTextFormField(
              controller: provider.ageSiblingControllers[index],
              hintText: 'Usia..',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
            const CustomLabelBiodata(text: 'Pendidikan'),
            _buildDropdown(
              context,
              value: provider.educationSiblingOptions[index],
              items: provider.itemsEducation,
              label: 'Pilih Pendidikan',
              onChanged: (val) => provider.setSiblingEducation(index, val),
              errorText: 'Wajib diisi',
            ),
            const CustomLabelBiodata(text: 'Pekerjaan (Opsional)'),
            CustomTextFormField(
              controller: provider.jobSiblingControllers[index],
              hintText: 'Pekerjaan..',
            ),
            const CustomLabelBiodata(text: 'Perusahaan (Opsional)'),
            CustomTextFormField(
              controller: provider.companySiblingControllers[index],
              hintText: 'Perusahaan..',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenForm(BuildContext context, FamilyProvider provider, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Anak ke-${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => provider.removeChildren(index),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const CustomLabelBiodata(text: 'Nama Lengkap'),
            CustomTextFormField(
              controller: provider.nameChildrenControllers[index],
              hintText: 'Nama anak..',
              validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
            const CustomLabelBiodata(text: 'Jenis Kelamin'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Laki-laki', style: TextStyle(fontSize: 14)),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'L',
                      groupValue: provider.genderChildrenControllers[index],
                      onChanged: (val) => provider.setChildGender(index, val!),
                      activeColor: AppColors.primary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Perempuan', style: TextStyle(fontSize: 14)),
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'P',
                      groupValue: provider.genderChildrenControllers[index],
                      onChanged: (val) => provider.setChildGender(index, val!),
                      activeColor: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const CustomLabelBiodata(text: 'Usia'),
            CustomTextFormField(
              controller: provider.ageChildrenControllers[index],
              hintText: 'Usia..',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
            const CustomLabelBiodata(text: 'Pendidikan Terakhir'),
            _buildDropdown(
              context,
              value: provider.educationChildrenOptions[index],
              items: provider.itemsLastEducation,
              label: 'Pilih Pendidikan',
              onChanged: (val) => provider.setChildEducation(index, val),
              errorText: 'Wajib diisi',
            ),
            const CustomLabelBiodata(text: 'Pekerjaan (Opsional)'),
            CustomTextFormField(
              controller: provider.jobChildrenControllers[index],
              hintText: 'Pekerjaan..',
            ),
            const CustomLabelBiodata(text: 'Perusahaan (Opsional)'),
            CustomTextFormField(
              controller: provider.companyChildrenControllers[index],
              hintText: 'Perusahaan..',
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderScrollFamily extends StatelessWidget {
  const HeaderScrollFamily({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _checkContract(isActive: true, number: 1, title: "Biodata"),
                _checkContract(isActive: true, number: 2, title: "Riwayat Pendidikan"),
                _checkContract(isActive: true, number: 3, title: "Data Keluarga"),
                _checkContract(number: 4, title: "Kelengkapan Dokumen"),
                _checkContract(number: 5, title: "Keahlian"),
                _checkContract(number: 6, title: "Ambil Foto Selfie"),
                _checkContract(number: 7, title: "Ambil Foto Selfie dengan KTP"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkContract({required int number, required String title, bool isActive = false}) {
    return Row(
      children: [
        if (number != 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            border: Border.all(color: isActive ? AppColors.primary : AppColors.secondary),
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
