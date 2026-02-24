import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/services/biodata_step_manager.dart';
import '../providers/biodata_provider.dart';
import '../widgets/welcome_dialogs.dart';
import '../widgets/welcome_menu_grid.dart';

class WelcomeBiodata extends StatefulWidget {
  const WelcomeBiodata({super.key});

  @override
  State<WelcomeBiodata> createState() => _WelcomeBiodataState();
}

class _WelcomeBiodataState extends State<WelcomeBiodata> {
  @override
  void initState() {
    super.initState();

    // Defer the dialog and data fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BiodataProvider>().loadBiodata();
      _showWelcomeFlow();
    });
  }

  void _showWelcomeFlow() {
    WelcomeDialogs.showWelcomeGreetingDialog(
      context: context,
      onNext: () {
        WelcomeDialogs.showRegulationAgreementDialog(
          context: context,
          onNext: () {
            WelcomeDialogs.showDataCompletionPromptDialog(
              context: context,
              onConfirm: () async {
                BiodataStepManager.setNextStep(AppRoutes.biodataForm.path);
                context.goNamed(AppRoutes.biodataForm.name);
              },
            );
          },
        );
      },
    );
  }

  Future<void> saveDataToPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    // Assuming simple calculation for now or fetch from provider if available
    double currentPoints = 3000;
    double totalPoints = 3800;
    double progress = currentPoints / totalPoints;

    return Consumer<BiodataProvider>(
      builder: (context, provider, child) {
        final biodata = provider.biodata;
        final fullName = biodata?.fullname ?? '...';
        final position = biodata?.jobTitle ?? '...';
        final photoUrl = biodata?.photoUrl;

        return Scaffold(
          body: WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                                      ? NetworkImage(photoUrl)
                                      : const AssetImage('assets/images/icon/profile_kosong.webp')
                                            as ImageProvider,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        fullName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        position,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.notifications, color: Colors.white, size: 25),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () async {
                                    // Logout logic here
                                    // For now just navigate to login
                                    context.goNamed(AppRoutes.login.name);
                                  },
                                  child: const Icon(
                                    Icons.logout, // FontAwesome fallback
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            'assets/images/maha-blur.png',
                            width: 250,
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const WelcomeMenuGrid(),
                  ],
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10), // AppBorderRadius fallback
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icon/home-poin.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '3.000/3.800 Poin',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        decoration: TextDecoration.none,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      child: LinearProgressIndicator(
                                        value: progress,
                                        backgroundColor: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                        valueColor: const AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 244, 224, 15),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      '200 Poin belum tercapai',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        decoration: TextDecoration.none,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
