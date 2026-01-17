// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/alert.dart';
import '../models/model_sign_in.dart';

class SignInService {
  final Dio _dio = Dio();

  Future<ModelSignIn> signIn({
    required BuildContext context,
  }) async {
    try {
      // final token = await AuthHelper.getToken();
      // final id = await AuthHelper.getEmployeeId();
      final response = await _dio.get(
        "",
        // "${Config.baseUrlGolang + Config.overtimeV2}/get-by-employee/$id",
        // options: Options(headers: {'Authorization': '$token'}),
      );
      return ModelSignIn.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ??
          'Terjadi kesalahan. Silakan coba lagi.';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertShowGagal(
            berhasil: "Gagal!",
            iconGagal: "assets/images/icon/ditolak.png",
            onPressed: () {
              Navigator.of(context).pop();
            },
            widget: Text.rich(
              TextSpan(
                text: '$errorMessage.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff999999),
                ),
                children: [
                  TextSpan(
                    text: ' Silakan coba lagi.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff404040),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      rethrow;
    }
  }
}
