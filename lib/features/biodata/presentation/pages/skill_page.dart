import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/skill_provider.dart'; // Ensure this model/provider matches
import '../widgets/skill_selection_dialog.dart';

class SkillPage extends StatelessWidget {
  const SkillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Formulir Data Diri'),
      body: Consumer<SkillProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingSkill) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 50, bottom: 90),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Keahlian',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tambahkan keahlian yang dimiliki yang kamu kuasai. ',
                        style: TextStyle(color: AppColors.secondary, fontSize: 14),
                      ),
                      const Text(
                        'Contoh : Memasak, Bahasa Jerman, Bermain Gitar',
                        style: TextStyle(color: AppColors.secondary, fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xff106AE8),
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xff106AE8), width: 1.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (_) => ChangeNotifierProvider.value(
                                  value: provider, // Pass the existing provider
                                  child: SkillSelectionDialog(
                                    initialSelectedSkills: provider.selectedSkills,
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: Color(0xff106AE8), size: 18),
                                // Replaced SvgPicture with Icon for simplicity if asset missing, or use Asset if available
                                // SvgPicture.asset("assets/images/icon/Plus.svg"),
                                SizedBox(width: 10),
                                Text("Tambah Keahlian"),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: [
                            ...provider.selectedSkills.map((skill) {
                              return Chip(
                                label: Text(skill.name),
                                deleteIcon: const Icon(Icons.close, size: 16),
                                onDeleted: () {
                                  provider.removeSkill(skill);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(color: Colors.grey, width: 1),
                                ),
                                backgroundColor: Colors.white,
                              );
                            }),
                            ...provider.newSkills.map((skillName) {
                              return Chip(
                                label: Text(skillName),
                                deleteIcon: const Icon(Icons.close, size: 16),
                                onDeleted: () {
                                  provider.removeNewSkill(skillName);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(color: Colors.grey, width: 1),
                                ),
                                backgroundColor: Colors.white,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const HeaderScrollSkill(),
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
                  final provider = context.read<SkillProvider>();
                  final isValid = await provider.submit();

                  if (isValid && context.mounted) {
                    context.pushNamed(RouteNames.selfieForm);
                  } else if (!isValid) {
                    // Show error message
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pilih minimal 1 keahlian!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
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
}

class HeaderScrollSkill extends StatelessWidget {
  const HeaderScrollSkill({super.key});

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
                _checkContract(isActive: true, number: 4, title: "Kelengkapan Dokumen"),
                _checkContract(isActive: true, number: 5, title: "Keahlian"),
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
