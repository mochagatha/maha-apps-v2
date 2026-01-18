import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
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
    "Staff": "nur.alimul@mahasejahtera.com",
    "Manajer TI": "setia@mahasejahtera.com", 
    "Komisaris": "kris@mahasejahtera.com",
    "Direktur": "hazri@mahasejahtera.com",
  };
  String? _selectedRole;

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
    );

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      context.go(RoutePaths.home);
    } else if (authProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage!),
          backgroundColor: AppColors.error,
        ),
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
                    Center(
                      child: Image.asset(
                        'assets/maha.png',
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                    // Role Dropdown (Optional Helper)
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: InputDecoration(
                        labelText: context.l10n.selectRole,
                        prefixIcon: const Icon(Icons.people_outline),
                      ),
                      items: _emailOptions.keys.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedRole = value;
                            _emailController.text = _emailOptions[value]!;
                            _passwordController.text = '123456'; // Default default
                          });
                        }
                      },
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
                      decoration: InputDecoration(
                        hintText: context.l10n.enterEmail,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
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
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
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
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Checkbox & Forgot Password
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.rememberMe,
                          style: const TextStyle(color: AppColors.neutral7),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to forgot password
                          },
                          child: Text(context.l10n.forgotPassword),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),

                    // Login Button
                    ElevatedButton(
                      onPressed: authProvider.isLoading ? null : _handleLogin,
                      child: authProvider.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(context.l10n.login),
                    ),

                    const SizedBox(height: 24),

                    // Register Link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(text: '${context.l10n.dontHaveAccount} '),
                            TextSpan(
                              text: context.l10n.register,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const PinVerificationDialog(),
                                  );
                                },
                            ),
                          ],
                        ),
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
