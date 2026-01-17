import 'package:flutter/material.dart';
import 'package:maha_apps_v2/widgets/loading.dart';

import '../../widgets/locale_storage.dart';
import '../models/model_sign_in.dart';
import '../services/sign_in_services.dart';

class ViewModelSignIn extends ChangeNotifier {
  final api = SignInService();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isObscure = true;
  bool isChecked = true;
  bool isButtonDisabled = true;
  ModelSignIn? signInModel;

  Future<void> submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      showLoadingLoginDialog(context);

      // final loginModel = LoginModel(
      //   email: _email.text,
      //   password: _password.text,
      // );
      try {
        // await context.read<LoginProvider>().procLoginPV(
        //   loginModel,
        //   _password.text,
        //   _isChecked,
        // );
        // if (!mounted) return;
        signInModel = await api.signIn(context: context);
        final authStorage = await AuthStorage.getInstance();
        await authStorage.saveLoginStatus(isChecked);
        await authStorage.saveLoginForGetLocation(isChecked);
        final isLoginRequired = await authStorage.checkLoginUser();
        if (!isLoginRequired) {
          // if (!mounted) return;

          // final documentProvider = context.read<GetDocumentByIDProvider>();
          // final signatureProvider = context.read<GetSignatureByIDProvider>();
          // final employeeDataProvider = context
          //     .read<GetAllDataEmployeByIDProvider>();

          // try {
          //   await Future.wait([
          //     documentProvider.fetchDocumentByIDPV(),
          //     signatureProvider.fetchSignatureByIDPV(),
          //     employeeDataProvider.fetchAllEmployeeDataByIDPV(),
          //   ]);
          //   // ignore: empty_catches
          // } catch (e) {}

          // var employee = employeeDataProvider.employeeData;

          // if (!mounted) return;
          // _hideLoadingLoginDialog(context);
          // if (employee?.data.status == 1) {
          //   String? educationStatus = await getDataFromPreferences('biodata');
          //   if (documentProvider.error == null &&
          //       signatureProvider.error != null) {
          //     Navigator.of(
          //       context,
          //     ).pushReplacementNamed(Routes.welcomeSignature);
          //   } else if (signatureProvider.error == null) {
          //     Navigator.of(context).pushReplacementNamed(Routes.statementOne);
          //   } else {
          //     // if (educationStatus == 'nama_lengkap') {
          //     //   Navigator.pushNamed(context, AppRoutes.biodataPageOne);
          //     // }
          //     //else if (educationStatus == 'riwayat_pendidikan') {
          //     //   Navigator.pushNamed(context, AppRoutes.education);
          //     // } else if (educationStatus == 'detail_rekening') {
          //     //   Navigator.pushNamed(context, AppRoutes.bank);
          //     // } else if (educationStatus == 'selfie') {
          //     //   Navigator.pushNamed(context, AppRoutes.selfie);
          //     // } else if (educationStatus == 'save_foto') {
          //     //   Navigator.pushNamed(context, AppRoutes.welcomeSignature);
          //     // }
          //     //  else {
          //     //   Navigator.of(context)
          //     //       .pushReplacementNamed(AppRoutes.welcomeBiodata);
          //     // }
          //     Navigator.of(context).pushReplacementNamed(Routes.welcomeBiodata);
          //   }
          // }
          // // else if (employee?.data.status == 2) {
          // //   CustomErrorDialogSvg.show(
          // //     context,
          // //     title: 'Maaf Sebelumnya!',
          // //     message:
          // //         "Akun Anda belum terverifikasi. Silahkan hubungi HRD Maha segera !",
          // //     imagePath: 'assets/images/svg/akun_anda_belum_terverifikasi.svg',
          // //     onPressed: () {
          // //       final encodedMessage = Uri.encodeFull(
          // //           "Halo admin, Saya sudah selesai mengisi data diri mohon dibantu untuk aktivasi akunnya, Terima Kasih");
          // //       final Uri whatsapp = Uri.parse(
          // //           "https://wa.me/6281364993863?text=$encodedMessage");
          // //       launchUrl(whatsapp);
          // //     },
          // //     widget: Row(
          // //       mainAxisAlignment: MainAxisAlignment.center,
          // //       children: [
          // //         Image.asset('assets/images/icon/whatsapp.png'),
          // //         const SizedBox(width: 8),
          // //         const Text(
          // //           'Hubungi Admin',
          // //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          // //         ),
          // //       ],
          // //     ),
          // //     gambar: Image.asset(
          // //       'assets/images/icon/success-register.png',
          // //     ),
          // //   );
          // // }
          // else if (employee?.data.status == 6) {
          //   if (employee?.data.contract?.contractStatus == 'permanent') {
          //     // Get.offAll(EmploymentAgreement());
          //     Navigator.of(context).pushReplacementNamed(Routes.agreementPkwtt);
          //   } else if (employee?.data.contract?.contractStatus == 'pkwt') {
          //     Navigator.of(context).pushReplacementNamed(Routes.agreementPkwt);
          //   } else {
          //     // Navigator.of(context)
          //     //     .pushReplacementNamed(AppRoutes.agreementProject);
          //     Get.off(EmploymentAgreementProject());
          //   }
          // } else if (employee?.data.status == 9) {
          //   Navigator.of(context).pushReplacementNamed(Routes.home);
          // } else if (employee?.data.status == 4) {
          // } else {
          //   // Navigator.of(context)
          //   //     .pushReplacementNamed(AppRoutes.welcomeBiodata);
          //   Navigator.of(context).pushReplacementNamed(Routes.home);
          // }
        } else {
          // if (!mounted) return;
          // _hideLoadingLoginDialog(context);
          // Navigator.of(context).pushReplacementNamed(Routes.login);
        }
      } catch (e) {
        // _hideLoadingLoginDialog(context);
        // String errorMessage;

        // if (e is ApiException) {
        //   errorMessage = e.message;
        // } else {
        //   errorMessage = 'Hubungi Departemen IT';
        // }

        // if (errorMessage == "Unverified account") {
        //   // showPopupRegister();
        //   CustomErrorDialogSvg.show(
        //     context,
        //     // title: 'Maaf Sebelumnya!',
        //     title: '',
        //     message:
        //         "Akun Anda belum terverifikasi. Silahkan hubungi HRD Maha segera !",
        //     imagePath: 'assets/images/svg/akun_anda_belum_terverifikasi.svg',
        //     onPressed: () {
        //       final encodedMessage = Uri.encodeFull(
        //         'Halo admin, Saya sudah selesai registrasi mohon dibantu untuk aktivasi akunnya, Terima kasih. ',
        //         // "Halo admin, Saya sudah selesai mengisi data diri mohon dibantu untuk aktivasi akunnya, Terima Kasih",
        //       );
        //       final Uri whatsapp = Uri.parse(
        //         "https://wa.me/6281364993863?text=$encodedMessage",
        //       );
        //       launchUrl(whatsapp);
        //     },
        //     widget: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset('assets/images/icon/whatsapp.png'),
        //         const SizedBox(width: 8),
        //         const Text(
        //           'Hubungi Admin',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        //         ),
        //       ],
        //     ),
        //     gambar: Image.asset('assets/images/icon/success-register.png'),
        //   );
        // }
        // // else if (errorMessage ==
        // //     "Silahkan periksa Email lalu Klik Tautan di email untuk memverifikasi akun anda!") {
        // // }
        // else {
        //   CustomErrorDialog.show(
        //     context,
        //     title: '',
        //     message: errorMessage,
        //     imagePath: 'assets/images/icon/pop-login.png',
        //   );
        // }
      }
    }
  }
}
