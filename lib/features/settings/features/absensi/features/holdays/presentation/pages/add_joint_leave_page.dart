import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/features/settings/features/absensi/features/holdays/presentation/providers/add_joint_leave_provider.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class AddJointLeavePage extends StatelessWidget {
  const AddJointLeavePage({super.key});

  void _pickStartDate(BuildContext context) async {
    final provider = context.read<AddJointLeaveProvider>();

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      provider.startDate = date;
      provider.startDateController.text = DateFormat("dd/MM/yyyy").format(date);
      provider.validate();
    }
  }

  void _pickEndDate(BuildContext context) async {
    final provider = context.read<AddJointLeaveProvider>();
    final start = provider.startDate ?? DateTime.now();

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: start,
      lastDate: DateTime(start.year + 1, start.month, start.day),
    );

    if (date != null) {
      provider.endDate = date;
      provider.endDateController.text = DateFormat("dd/MM/yyyy").format(date);
      provider.validate();
    }
  }

  void _submit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _ConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddJointLeaveProvider>();

    return Scaffold(
      appBar: CustomAppBar(title: "Tambah Cuti Bersama"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Nama"),
            CustomTextFormField(
              controller: provider.nameController,
              hintText: "Tulis nama cuti bersama disini",
              keyboardType: TextInputType.name,
              onChanged: provider.validate,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Tanggal Mulai"),
                      _buildTextField(
                        controller: provider.startDateController,
                        onTap: () => _pickStartDate(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Tanggal Selesai"),
                      _buildTextField(
                        controller: provider.endDateController,
                        onTap: () => _pickEndDate(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Selector<AddJointLeaveProvider, bool>(
        selector: (_, provider) => provider.valid,
        builder: (context, valid, child) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: CustomElevatedButton(
              onPressed: () => _submit(context),
              loading: !valid,
              child: Text("Simpan"),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
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
    );
  }

  InputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Maaf Sebelumnya...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8),
            Image.asset(
              "assets/images/icon/submit-biodata.png",
              height: 100,
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Apakah Anda yakin ingin menambah "),
                  TextSpan(
                    text: "Hari Libur",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " ini?"),
                ],
              ),
              style: TextStyle(color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Row(
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
          ],
        ),
      ),
    );
  }
}
