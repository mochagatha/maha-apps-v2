///Button default(button approve atau tolak)X

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maha_apps_v2/widgets/colors.dart';

import '../sign_up/screens/sign_up.dart';

class BottomSheetTerms extends StatelessWidget {
  const BottomSheetTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: AppColors.secondaryColor),
        children: <TextSpan>[
          const TextSpan(text: 'Tidak punya akun? '),

          // Teks yang dapat diklik "Daftar disini"
          TextSpan(
            text: 'Daftar disini',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Menampilkan modal bottom sheet saat teks ditekan
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  builder: (context) {
                    bool isChecked2 = false;
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return FractionallySizedBox(
                          heightFactor: 0.7,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Garis kecil di atas bottom sheet untuk estetika
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                              left: Radius.circular(10),
                                              right: Radius.circular(10),
                                            ),
                                        child: Container(
                                          height: 5,
                                          width: 70,
                                          color: AppColors.secondaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                              left: Radius.circular(10),
                                              right: Radius.circular(10),
                                            ),
                                        child: Container(
                                          height: 0.4,
                                          width: 400,
                                          color: AppColors.secondaryColor,
                                        ),
                                      ),
                                    ),

                                    // Gambar logo
                                    Image.asset("assets/maha.png"),
                                    const SizedBox(height: 20),

                                    // Judul
                                    const Text(
                                      'Syarat & Ketentuan Penggunaaan dan Pemberitahuan Privasi MAHA Apps Mobile',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 17),

                                    // Deskripsi singkat
                                    const Text(
                                      'Syarat & Ketentuan Penggunaaan dan Pemberitahuan Privasi merupakan ketentuan yang harus dibaca, dipahami, dan disetujui oleh pengguna sebelum mengakses atau menggunakan aplikasi MAHA Apps Mobile. Lihat selengkapnya di sini:',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),

                                    // Tautan ke syarat dan ketentuan
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            color: Colors.black,
                                            size: 5,
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.pushNamed(
                                              //     context, Routes.terms);
                                            },
                                            child: const Text(
                                              'Syarat & Ketentuan Penggunaan',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Tautan ke pemberitahuan privasi
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            color: Colors.black,
                                            size: 5,
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.pushNamed(
                                              //     context, Routes.privacy);
                                            },
                                            child: const Text(
                                              'Pemberitahuan Privasi',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Checkbox persetujuan syarat & ketentuan
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200,
                                      ),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            activeColor: AppColors.primaryColor,
                                            value: isChecked2,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked2 = value!;
                                              });
                                            },
                                          ),
                                          const Expanded(
                                            child: Text(
                                              "Dengan ini menyatakan Setuju, anda menerima segala isi Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    // Tombol "Saya Setuju"
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: isChecked2
                                              ? () {
                                                        Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          SignUpScreen(),
                                                    ),
                                                  );
                                                  // Navigator
                                                  //     .pushReplacementNamed(
                                                  //         context,
                                                  //         Routes.register);
                                                }
                                              : null,
                                          style: elevatedButtonDecoration,
                                          child: const Text(
                                            'Saya Setuju',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
          ),
        ],
      ),
    );
  }
}

class AppBorderRadius {
  static BorderRadius roundedBorder = BorderRadius.circular(5.0);
}

final ButtonStyle elevatedButtonDecoration = ElevatedButton.styleFrom(
  backgroundColor: AppColors.primaryColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(vertical: 5.0),
  shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.roundedBorder),
);
