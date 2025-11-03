import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countmycalories/application/providers/profile_provider.dart';
import 'package:countmycalories/core/constants/app_colors.dart';
import 'package:countmycalories/core/constants/app_images.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _targetController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;
    _heightController = TextEditingController(text: profile.heightCm.toStringAsFixed(0));
    _weightController = TextEditingController(text: profile.weightKg.toStringAsFixed(1));
    _targetController = TextEditingController(text: profile.dailyCalorieTarget.toString());
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, width: 64, height: 64),
                  const SizedBox(width: 12),
                  Text(
                    'Minha meta',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'INFORME OS DADOS INICIAIS PARA COMEÇAR SEU\nACOMPANHAMENTO!'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.accentOrange, fontSize: 12),
              ),
              const SizedBox(height: 24),
              const _Label('CALORIA DIÁRIA'),
              const SizedBox(height: 6),
              _RoundedField(controller: _targetController, hint: '1500', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              const _Label('PESO'),
              const SizedBox(height: 6),
              _RoundedField(controller: _weightController, hint: '90kg', keyboardType: TextInputType.text),
              const SizedBox(height: 16),
              const _Label('ALTURA'),
              const SizedBox(height: 6),
              _RoundedField(controller: _heightController, hint: '172cm', keyboardType: TextInputType.text),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    final height = double.tryParse(_heightController.text.replaceAll(',', '.').replaceAll('cm', '').trim()) ?? 0;
                    final weight = double.tryParse(_weightController.text.replaceAll(',', '.').replaceAll('kg', '').trim()) ?? 0;
                    final target = int.tryParse(_targetController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                    context.read<ProfileProvider>().update(
                          heightCm: height,
                          weightKg: weight,
                          dailyTarget: target,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Configurações salvas')),
                    );
                  },
                  child: const Text('Salvar', style: TextStyle(fontSize: 18)),
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
  final TextInputType keyboardType;
  const _RoundedField({required this.controller, required this.hint, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEDEDED),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}


