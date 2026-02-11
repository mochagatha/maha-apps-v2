import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/error_dialog.dart';
import '../providers/access_menu_provider.dart';
import '../widgets/menu_access_item_widget.dart';

/// Main page for managing employee menu access
class AccessMenuListPage extends StatefulWidget {
  const AccessMenuListPage({
    super.key,
    required this.employeeId,
  });

  final int employeeId;

  @override
  State<AccessMenuListPage> createState() => _AccessMenuListPageState();
}

class _AccessMenuListPageState extends State<AccessMenuListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccessMenuProvider>().loadMenus(widget.employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Akses Menu'),
      body: Consumer<AccessMenuProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.allMenus.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (provider.errorMessage != null && provider.allMenus.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.loadMenus(widget.employeeId);
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          final menus = provider.allMenus;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Daftar Menu Aplikasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    final menu = menus[index];
                    return MenuAccessItemWidget(menu: menu);
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<AccessMenuProvider>(
        builder: (context, provider, child) {
          return BottomAppBar(
            height: 70,
            elevation: 0,
            color: Colors.white,
            child: _SubmitButton(
              employeeId: widget.employeeId,
              loading: provider.isLoading,
            ),
          );
        },
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({
    required this.employeeId,
    required this.loading,
  });

  final int employeeId;
  final bool loading;

  @override
  State<_SubmitButton> createState() => __SubmitButtonState();
}

class __SubmitButtonState extends State<_SubmitButton> {
  bool _submitting = false;

  void _submit() async {
    setState(() => _submitting = true);

    final provider = context.read<AccessMenuProvider>();
    final success = await provider.submitChanges(widget.employeeId);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
    } else {
      setState(() => _submitting = false);
      if (provider.errorMessage != null) {
        ErrorDialog.show(
          context,
          message: provider.errorMessage!,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.loading || _submitting;

    return ElevatedButton(
      onPressed: isLoading ? null : _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        disabledBackgroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Text(
              'Terapkan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }
}
