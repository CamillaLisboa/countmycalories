import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countmycalories/application/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:countmycalories/core/constants/app_routes.dart';
import 'package:countmycalories/core/constants/app_strings.dart';
import 'package:countmycalories/core/constants/app_colors.dart';
import 'package:countmycalories/core/constants/app_images.dart';

class LoginViewAndroid extends StatefulWidget {
  const LoginViewAndroid({super.key});

  @override
  State<LoginViewAndroid> createState() => _LoginViewAndroidState();
}

class _LoginViewAndroidState extends State<LoginViewAndroid> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Image.asset(AppImages.logo, width: 120, height: 120),
              const SizedBox(height: 24),
              Text(
                'Sua saúde\ncomeça com o\nque você conta.',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'que você conta.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.accentOrange,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              _RoundedField(controller: _emailController, hint: 'Username'),
              const SizedBox(height: 12),
              _RoundedField(controller: _passwordController, hint: 'Password', obscure: true),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Forgot Password?', style: TextStyle(color: AppColors.textGray, fontSize: 12)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          final success = await context.read<AuthProvider>().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                          if (!mounted) return;
                          if (success) {
                            context.go(AppRoutes.home);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Falha no login')),
                            );
                          }
                        },
                  child: isLoading
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialIcon(asset: AppImages.google),
                  const SizedBox(width: 16),
                  const CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.apple, color: Colors.white)),
                  const SizedBox(width: 16),
                  const CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.window, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => context.go(AppRoutes.signup),
                child: const Text('Ou Cadastre-se.', style: TextStyle(decoration: TextDecoration.underline)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundedField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  const _RoundedField({required this.controller, required this.hint, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black54, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black87, width: 2),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String asset;
  const _SocialIcon({required this.asset});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 18,
      child: Image.asset(asset, width: 24, height: 24),
    );
  }
}


