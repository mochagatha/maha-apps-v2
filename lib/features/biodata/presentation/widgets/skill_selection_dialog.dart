import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/skill_provider.dart';

class SkillSelectionDialog extends StatefulWidget {
  final List<SkillModel> initialSelectedSkills;
  
  const SkillSelectionDialog({
    super.key,
    required this.initialSelectedSkills,
  });

  @override
  State<SkillSelectionDialog> createState() => _SkillSelectionDialogState();
}

class _SkillSelectionDialogState extends State<SkillSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<SkillModel> _tempSelectedSkills = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tempSelectedSkills = List.from(widget.initialSelectedSkills);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SkillProvider>();
    // Filter available skills based on search
    final filteredSkills = provider.availableSkills.where((skill) {
      if (_searchQuery.isEmpty) return true;
      return skill.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 14),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(), // Spacer
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
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                   setState(() {
                     _tempSelectedSkills.clear();
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
          children: [
             TextFormField(
              controller: _searchController,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                labelText: 'Ketik disini..',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: const OutlineInputBorder(
                   borderSide: BorderSide(color: AppColors.primary)
                )
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredSkills.isEmpty
                  ? const Center(child: Text('Keahlian tidak ditemukan'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredSkills.length,
                      itemBuilder: (context, index) {
                        final skill = filteredSkills[index];
                        final isSelected = _tempSelectedSkills.any((s) => s.id == skill.id);
                        return CheckboxListTile(
                          title: Text(skill.name),
                          value: isSelected,
                          activeColor: AppColors.primary,
                          checkColor: Colors.white,
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
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            // Update the provider with the temp selection
            // We need a way to sync back. 
            // In v1, it called submitIDSkills directly.
            // Here, we'll update the selected list in provider.
            
            // Clear current selection and add new ones (inefficient but safe)
            provider.selectedSkills.clear(); 
            provider.selectedSkills.addAll(_tempSelectedSkills);
            provider.notifyListeners(); // Force update
            
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
