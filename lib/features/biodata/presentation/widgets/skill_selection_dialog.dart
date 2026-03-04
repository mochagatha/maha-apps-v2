import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/skill_provider.dart';

class SkillSelectionDialog extends StatefulWidget {
  final List<SkillModel> initialSelectedSkills;
  final List<String> initialCustomSkills;

  const SkillSelectionDialog({
    super.key,
    required this.initialSelectedSkills,
    this.initialCustomSkills = const [],
  });

  @override
  State<SkillSelectionDialog> createState() => _SkillSelectionDialogState();
}

class _SkillSelectionDialogState extends State<SkillSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<SkillModel> _tempSelectedSkills = [];
  List<String> _tempCustomSkills = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tempSelectedSkills = List.from(widget.initialSelectedSkills);
    _tempCustomSkills = List.from(widget.initialCustomSkills);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addCustomSkill(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final alreadyPredefined = _tempSelectedSkills.any(
      (s) => s.name.toLowerCase() == trimmed.toLowerCase(),
    );
    final alreadyCustom = _tempCustomSkills.any(
      (s) => s.toLowerCase() == trimmed.toLowerCase(),
    );
    if (!alreadyPredefined && !alreadyCustom) {
      setState(() {
        _tempCustomSkills.add(trimmed);
        _searchController.clear();
        _searchQuery = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SkillProvider>();

    // Filter predefined skills based on search
    final filteredSkills = provider.availableSkills.where((skill) {
      if (_searchQuery.isEmpty) return true;
      return skill.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Show "add custom" option when search text doesn't exactly match any predefined skill
    final showAddCustom =
        _searchQuery.trim().isNotEmpty &&
        !provider.availableSkills.any(
          (s) => s.name.toLowerCase() == _searchQuery.trim().toLowerCase(),
        ) &&
        !_tempCustomSkills.any(
          (s) => s.toLowerCase() == _searchQuery.trim().toLowerCase(),
        );

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 14),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilih Keahlian yang Dimiliki',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _tempSelectedSkills.clear();
                    _tempCustomSkills.clear();
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(color: AppColors.primary, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _searchController,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                labelText: 'Cari atau ketik keahlian baru..',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 8),

            // Custom skills chips
            if (_tempCustomSkills.isNotEmpty) ...[
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: _tempCustomSkills
                    .map(
                      (name) => Chip(
                        label: Text(name, style: const TextStyle(fontSize: 12)),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () => setState(() => _tempCustomSkills.remove(name)),
                        backgroundColor: const Color(0xffE8F0FE),
                        side: const BorderSide(color: Color(0xff106AE8)),
                        padding: EdgeInsets.zero,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
            ],

            Expanded(
              child: ListView(
                children: [
                  // "Tambahkan" option when typing something not in the list
                  if (showAddCustom)
                    ListTile(
                      leading: const Icon(Icons.add_circle_outline, color: Color(0xff106AE8)),
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black87, fontSize: 14),
                          children: [
                            const TextSpan(text: 'Tambahkan "'),
                            TextSpan(
                              text: _searchQuery.trim(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: '"'),
                          ],
                        ),
                      ),
                      onTap: () => _addCustomSkill(_searchQuery),
                      contentPadding: EdgeInsets.zero,
                    ),

                  // Predefined skills list
                  if (filteredSkills.isEmpty && !showAddCustom)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: Text('Keahlian tidak ditemukan')),
                    )
                  else
                    ...filteredSkills.map((skill) {
                      final isSelected = _tempSelectedSkills.any((s) => s.id == skill.id);
                      return CheckboxListTile(
                        title: Text(skill.name),
                        value: isSelected,
                        activeColor: AppColors.primary,
                        checkColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              if (!_tempSelectedSkills.any((s) => s.id == skill.id)) {
                                _tempSelectedSkills.add(skill);
                              }
                            } else {
                              _tempSelectedSkills.removeWhere((s) => s.id == skill.id);
                            }
                          });
                        },
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            provider.syncSelectedSkills(_tempSelectedSkills, _tempCustomSkills);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Simpan',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
