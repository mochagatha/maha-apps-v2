// Login Page - Preserving v1 UI/UX exactly
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/colors.dart';
import '../../../../widgets/font.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isChecked = true;

  @override
  void initState() {
    super.initState();
    // Listen to auth status changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      authProvider.addListener(_onAuthStateChanged);
    });
  }

  void _onAuthStateChanged() {
    final authProvider = context.read<AuthProvider>();

    if (authProvider.status == AuthStatus.authenticated) {
      // Navigate to home
      context.go('/home');
    } else if (authProvider.status == AuthStatus.error) {
      // Show error dialog (matching v1 style)
      if (authProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage!),
            backgroundColor: AppColors.primaryColor,
          ),
        );
        authProvider.clearError();
      }
    }
  }

  @override
  void dispose() {
    context.read<AuthProvider>().removeListener(_onAuthStateChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      authProvider.loginUser(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Image.asset("assets/maha.png"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  
                  // Email Field
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
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: _emailController,
                    cursorColor: AppColors.primaryColor,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Masukkan email anda..',
                    ),
                  ),
                  const SizedBox(height: 22),
                  
                  // Password Field
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
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return TextFormField(
                        controller: _passwordController,
                        cursorColor: AppColors.primaryColor,
                        obscureText: _isObscure,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Masukkan kata sandi anda..',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            color: _isObscure
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor,
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  
                  // Remember Me & Forgot Password
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.primaryColor,
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
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
                          // TODO: Navigate to forgot password
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
                  ),

                  const SizedBox(height: 30),
                  
                  // Login Button
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      final isButtonDisabled = authProvider.isLoading;
                      
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isButtonDisabled ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isButtonDisabled
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppBorderRadius.roundedBorder,
                            ),
                          ),
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
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
                    '©opyright IT Maha ${DateTime.now().year}',
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
