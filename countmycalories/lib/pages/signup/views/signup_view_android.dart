import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countmycalories/application/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:countmycalories/core/constants/app_routes.dart';
import 'package:countmycalories/core/constants/app_colors.dart';
import 'package:countmycalories/core/constants/app_images.dart';

class SignupViewAndroid extends StatefulWidget {
  const SignupViewAndroid({super.key});

  @override
  State<SignupViewAndroid> createState() => _SignupViewAndroidState();
}

class _SignupViewAndroidState extends State<SignupViewAndroid> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
              const SizedBox(height: 16),
              Text(
                'Create New\nAccount',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Registered? '),
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.login),
                    child: const Text('Log in here.', style: TextStyle(decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _Label('NAME'),
              const SizedBox(height: 6),
              _RoundedField(controller: _nameController, hint: 'Jiara Martins'),
              const SizedBox(height: 16),
              _Label('EMAIL'),
              const SizedBox(height: 6),
              _RoundedField(controller: _emailController, hint: 'hello@reallygreatsite.com'),
              const SizedBox(height: 16),
              _Label('PASSWORD'),
              const SizedBox(height: 6),
              _RoundedField(controller: _passwordController, hint: '*****', obscure: true),
              const SizedBox(height: 24),
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
                          // Mock: cadastro = login direto
                          final success = await context.read<AuthProvider>().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                          if (!mounted) return;
                          if (success) {
                            context.go(AppRoutes.home);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Falha no cadastro')),
                            );
                          }
                        },
                  child: isLoading
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Sign up'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(letterSpacing: 2, color: Colors.black54));
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
        filled: true,
        fillColor: const Color(0xFFEDEDED),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
      enabled: true,
      readOnly: false,
      textInputAction: TextInputAction.next,
      keyboardType: obscure ? TextInputType.text : TextInputType.text,
    );
  }
}


