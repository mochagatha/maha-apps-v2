import 'package:flutter/material.dart';
import 'package:maha_apps_v2/sign_in/view_models/view_model_sign_in.dart';
import 'package:maha_apps_v2/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../widgets/colors.dart';
import '../../widgets/font.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late ViewModelSignIn viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ViewModelSignIn>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Image.asset("assets/maha.png"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // HARUS OFFFF JANGAN COMENT
                  // DropdownButtonFormField<String>(
                  //   value: _selectedRole,
                  //   decoration: textInputDecoration.copyWith(
                  //     labelText: "Pilih role...",
                  //   ),
                  //   items: emailOptions.keys.map((role) {
                  //     return DropdownMenuItem(value: role, child: Text(role));
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedRole = value;
                  //       _email.text =
                  //           emailOptions[value]!; // isi otomatis email
                  //       _password.text =
                  //           defaultPassword; // isi otomatis password
                  //     });
                  //   },
                  // ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: viewModel.email,
                    cursorColor: AppColors.primaryColor,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Masukkan email anda..',
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Row(
                    children: [
                      Text(
                        'Kata Sandi',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Consumer<ViewModelSignIn>(
                    builder: (context, _, child) {
                      return TextFormField(
                        controller: viewModel.password,
                        cursorColor: AppColors.primaryColor,
                        obscureText: viewModel.isObscure,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Masukkan kata sandi anda..',
                          suffixIcon: IconButton(
                            icon: Icon(
                              viewModel.isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            color: viewModel.isObscure
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor,
                            onPressed: () {
                              // setState(() {
                              viewModel.isObscure = !viewModel.isObscure;
                              // });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Consumer<ViewModelSignIn>(
                    builder: (context, _, child) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: AppColors.primaryColor,
                              value: viewModel.isChecked,
                              onChanged: (bool? value) {
                                viewModel.isChecked = value!;
                              },
                            ),
                          ),
                          SizedBox(width: 6),
                          const Text(
                            "Tetap masuk",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => InputEmailForgetPassword(),
                              //   ),
                              // );
                            },
                            child: const Text(
                              "Lupa kata sandi?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  Consumer<ViewModelSignIn>(
                    builder: (context, _, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: viewModel.isButtonDisabled
                              ? null
                              : () => viewModel.submitForm(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: viewModel.isButtonDisabled
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppBorderRadius.roundedBorder,
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                  const BottomSheetTerms(),
                  const SizedBox(height: 80),
                  Text(
                    '\u00A9opyright IT Maha ${DateTime.now().year}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
