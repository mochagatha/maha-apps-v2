import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../screen_security/presentation/providers/screen_security_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/pin_verification_dialog.dart';

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
  bool _rememberMe = true;

  // Pre-filled roles for quick testing (from V1)
  final Map<String, String> _emailOptions = {
    "Staff": "bahrul@mahasejahtera.com",
    "Manajer TI": "setia@mahasejahtera.com",
    "Komisaris": "kris@mahasejahtera.com",
    "Direktur": "hazri@mahasejahtera.com",
    "System Admin": "admin@mahasejahtera.com",
  };
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    // Reset auth status ketika masuk ke login page
    // untuk menghindari tombol login dalam kondisi loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.status == AuthStatus.loading) {
        authProvider.resetToUnauthenticated();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    // Close keyboard
    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();

    await authProvider.loginUser(
      _emailController.text.trim(),
      _passwordController.text,
      rememberMe: _rememberMe,
    );

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      // Apply screen security settings after successful login
      final screenSecurityProvider = context.read<ScreenSecurityProvider>();
      if (authProvider.user?.employeeId != null) {
        await screenSecurityProvider.fetchAndApplySecuritySettings(
          type: 'employee',
          employeeWorkerId: authProvider.user!.employeeId!,
        );

        if (kDebugMode) {
          print('Screen security applied: ${screenSecurityProvider.isSecurityEnabled}');
        }
      }

      if (!mounted) return;

      // Check if the user is admin
      final email = _emailController.text.trim().toLowerCase();
      if (email == 'admin@mahasejahtera.com') {
        // Set admin status
        await authProvider.setAdminStatus(true);
        // Navigate to admin face verification
        context.go(AppRoutes.adminFaceVerification.path);
      } else {
        await authProvider.setAdminStatus(false);
        if (authProvider.user?.status == 1) {
          context.go(AppRoutes.welcomeBiodata.path);
        } else {
          context.go(AppRoutes.home.path);
        }
      }
    } else if (authProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage!), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    // Logo
                    Center(child: Image.asset('assets/maha.png', height: 100)),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    // Role Dropdown (Optional Helper)
                    Visibility(
                      visible: kDebugMode,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          labelText: context.l10n.selectRole,
                          prefixIcon: const Icon(Icons.people_outline),
                        ),
                        items: _emailOptions.keys.map((role) {
                          return DropdownMenuItem(value: role, child: Text(role));
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedRole = value;
                              _emailController.text = _emailOptions[value]!;
                              _passwordController.text = 'E!!fu!0T--T4~h@7hQ'; // Default default
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    Text(
                      context.l10n.email,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: context.l10n.enterEmail),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.emailRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Password Field
                    Text(
                      context.l10n.password,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: context.l10n.enterPassword,
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.passwordRequired;
                        }
                        if (value.length < 6) {
                          return context.l10n.passwordMinLength;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 8),

                    // Remember Me Checkbox & Forgot Password
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            context.push(AppRoutes.forgotPassword.path);
                          },
                          child: Text(
                            context.l10n.forgotPassword,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Login Button
                    ElevatedButton(
                      onPressed: authProvider.isLoading ? null : _handleLogin,
                      child: authProvider.isLoading
                          ? const SpinKitThreeBounce(color: Colors.white, size: 24.0)
                          : Text(context.l10n.login),
                    ),

                    const SizedBox(height: 24),

                    // Register Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${context.l10n.dontHaveAccount} ',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const PinVerificationDialog(),
                              );
                            },
                            child: Text(
                              context.l10n.register,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        context.l10n.copyright(DateTime.now().year.toString()),
                        style: const TextStyle(color: AppColors.neutral5, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
