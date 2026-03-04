import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/bank_provider.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_text_form_field.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_search_dropdown.dart';
import 'package:provider/provider.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BankProvider>().loadBanks();
    });
  }

  String? Function(dynamic) _emptyValidator(String hint) {
    return (value) {
      if (value == null || value == "") return "$hint tidak boleh kosong";
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    final bankProvider = context.read<BankProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Mengisi Data Rekening",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: bankProvider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rekening Bank",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Bahwa benar dan tanpa paksaan rekening yang saya isi di bawah ini adalah milik saya pribadi.",
                style: TextStyle(fontSize: 12),
              ),

              _FieldLabel(text: "Nama Bank"),
              SizedBox(height: 12),
              Consumer<BankProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSearchDropdown(
                        items: provider.banks,
                        onChanged: (value) => provider.selectedBank = value,
                        itemAsString: (item) => item.name,
                        itemFromId: provider.bankFromId,
                        itemId: (item) => item.id,
                        hint: "Pilih bank tujuan Anda di sini...",
                        isLoading: provider.loadingBanks,
                        validator: _emptyValidator("Bank tujuan"),
                      ),
                      if (provider.loadBanksError != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                provider.loadBanksError!,
                                style: const TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => provider.loadBanks(),
                              icon: const Icon(Icons.refresh, size: 16),
                              label: const Text("Coba lagi"),
                            ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),

              _FieldLabel(text: "No. Rekening"),
              CustomTextFormField(
                controller: bankProvider.accountNumberController,
                hintText: "Contoh: 123456789xxxxxxxx",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _emptyValidator("Nomor rekening"),
              ),

              _FieldLabel(text: "Nama Pemilik Rekening"),
              CustomTextFormField(
                controller: bankProvider.accountNameController,
                hintText: "Masukkan nama pemilik rekening di sini...",
                keyboardType: TextInputType.name,
                validator: _emptyValidator("Nama pemilik rekening"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _SubmitButton(),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 12),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: text),
            TextSpan(
              text: " *",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton();

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _loading = false;

  void _submit() async {
    final provider = context.read<BankProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    setState(() => _loading = true);
    final error = await provider.submit();
    setState(() => _loading = false);

    if (error != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.grey.shade700,
        ),
      );
    } else {
      router.pushNamed(AppRoutes.biodataSignature.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomElevatedButton(
        onPressed: _submit,
        loading: _loading,
        child: Text("Simpan Data Rekening"),
      ),
    );
  }
}
