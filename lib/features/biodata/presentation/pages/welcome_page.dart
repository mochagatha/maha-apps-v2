import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/router/route_names.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/biodata_provider.dart';

class WelcomeBiodata extends StatefulWidget {
  const WelcomeBiodata({super.key});

  @override
  State<WelcomeBiodata> createState() => _WelcomeBiodataState();
}

class _WelcomeBiodataState extends State<WelcomeBiodata> {
  late List<Map<String, dynamic>> gridItems;

  // Initialize grid items properly in initState or build
  void _initGridItems() {
    gridItems = [
      {
        'icon': 'assets/images/icon/absensi.png',
        'label': 'Absensi',
        'action': () => context.pushNamed(RouteNames.absensi),
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/approval.png',
        'label': 'Approval',
        'action': () => context.pushNamed(RouteNames.approvalList),
        'isAsset': true,
      },
      // ... (Rest of the items similar to v1 but using updated routes if available)
      // For items without specific routes yet, we can show a placeholder or perform no action
      {
        'icon': 'assets/images/icon/rencanakerja.png',
        'label': 'Rencana Kerja',
        'action': () {},
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/permintaan.png',
        'label': 'Permintaan',
        'action': () => context.pushNamed(RouteNames.permintaan),
        'isAsset': true,
      },
      {'icon': 'assets/images/icon/tugas.png', 'label': 'Tugas', 'action': () {}, 'isAsset': true},
      {
        'icon': 'assets/images/icon/pengajuan.png',
        'label': 'Pengajuan',
        'action': () {},
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/administrasi.png',
        'label': 'Administrasi',
        'action': () => context.pushNamed(RouteNames.administration),
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/arsip.png',
        'label': 'Arsip',
        'action': () => context.pushNamed(RouteNames.arsipMenu), // Assuming map to arsip
        'isAsset': true,
      },
    ];
  }

  Future<String> downloadPdf(String url, String fileName) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/$fileName";
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          // Optional: Update progress
        },
      );
      return "File downloaded to $filePath";
    } catch (e) {
      return "Error downloading file: $e";
    }
  }

  @override
  void initState() {
    super.initState();
    _initGridItems();

    // Defer the dialog and data fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BiodataProvider>().loadEmployeeData();
      _showWelcomeDialog(context);
    });
  }

  void _showWelcomeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Selamat Bergabung !',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SvgPicture.asset("assets/images/icon/selamat_bergabung.svg"),
                  const SizedBox(height: 20),
                  const Text(
                    'Semoga Anda dapat memberikan kontribusi terbaik bagi perusahaan PT. Maha Akbar Sejahtera.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text('Direktur', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Hazri Fadillah Harahap, SE', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showSecondDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child: const Text(
                        'Selanjutnya',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSecondDialog(BuildContext context) {
    final ValueNotifier<bool> isAgree = ValueNotifier(false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = screenSize.width;

        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Peraturan Perusahaan !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset('assets/images/icon/Peraturan Perusahaan.png', height: 200),
                  const Text.rich(
                    TextSpan(
                      text: 'Sebelum Anda melanjutkan ke tahap ',
                      children: [
                        TextSpan(
                          text: 'pengisian data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              '. Harap baca terlebih dahulu peraturan PT. Maha Akbar Sejahtera...!',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isAgree,
                          builder: (context, value, child) {
                            return Checkbox(
                              activeColor: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              value: value,
                              onChanged: (newValue) {
                                isAgree.value = newValue!;
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              isAgree.value = !isAgree.value;
                            },
                            child: const Text(
                              'Dengan ini saya menyatakan bahwa saya menyetujui seluruh peraturan perusahaan',
                              style: TextStyle(fontSize: 10, color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final baseUrl =
                                dotenv.env['BASE_URL_PUBLIC'] ??
                                'https://public.maha-akbar.com'; // Fallback
                            await launchUrl(Uri.parse("$baseUrl/assets/doc/peraturan.pdf"));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.print, size: 14, color: Colors.white),
                              const SizedBox(width: 2.5),
                              Text(
                                'Unduh',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth < 360 ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: isAgree,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              onPressed: value
                                  ? () {
                                      Navigator.of(context).pop();
                                      _showNextDialog();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text(
                                'Lanjutkan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth < 360 ? 12 : 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNextDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Lengkapi Data diri Anda !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/icon/fill-biodata.png', height: 250),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      text: 'Dalam pengisian formulir ini, Anda membutuhkan waktu ',
                      children: [
                        TextSpan(
                          text: '10 Menit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '. Harap diisi dengan sejujurnya yah !'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text('Semangat', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Be Great, Be Integrated', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Navigate to Biodata Page - Need to defined Route or use existing
                        // Placeholder navigation for now
                        await saveDataToPreferences('biodata', 'nama_lengkap');
                        // context.go(RoutePaths.biodataPageOne); // Example
                        Navigator.of(context).pop(); // Just close for now for demo
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child: const Text(
                        'Oke',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        final employee = provider.employee;
        final fullName = employee?.fullname ?? '...';
        final position = employee?.jobTitle ?? '...';
        final photoUrl = employee?.photoUrl;

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
                                    context.goNamed(RouteNames.login);
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
                    GridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(gridItems.length, (index) {
                        return GestureDetector(
                          onTap: gridItems[index]['action'],
                          child: Column(
                            children: [
                              gridItems[index]['isAsset']
                                  ? Image.asset(gridItems[index]['icon'], width: 50, height: 50)
                                  : Icon(
                                      gridItems[index]['icon'],
                                      size: 40,
                                      color: AppColors.primary,
                                    ),
                              const SizedBox(height: 8),
                              Text(
                                gridItems[index]['label'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
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
