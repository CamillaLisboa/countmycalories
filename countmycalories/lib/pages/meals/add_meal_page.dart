import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:countmycalories/application/providers/meal_provider.dart';
import 'package:countmycalories/core/constants/app_colors.dart';
import 'package:countmycalories/core/constants/app_images.dart';
import 'package:countmycalories/core/constants/app_routes.dart';
import 'package:countmycalories/core/constants/food_calories.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final TextEditingController _weightController = TextEditingController();
  String? _selectedFood;
  String? _selectedMeal;

  final List<String> _foods = <String>[
    'Arroz',
    'Feijão',
    'Frango',
    'Salada',
    'Ovo',
    'Iogurte',
  ];

  final List<String> _meals = <String>[
    'Café da manhã',
    'Almoço',
    'Jantar',
    'Snack',
  ];

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, width: 64, height: 64),
                  const SizedBox(width: 12),
                  Text(
                    'Novo\nConsumo',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _Label('ALIMENTO'),
              const SizedBox(height: 6),
              _RoundedDropdown<String>(
                value: _selectedFood,
                hint: 'Selecione o alimento',
                items: _foods.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _selectedFood = v),
              ),
              const SizedBox(height: 16),
              const _Label('PESO/UNIDADE (g)'),
              const SizedBox(height: 6),
              _RoundedField(controller: _weightController, hint: ''),
              const SizedBox(height: 16),
              const _Label('REFEIÇÃO'),
              const SizedBox(height: 6),
              _RoundedDropdown<String>(
                value: _selectedMeal,
                hint: 'Selecione a refeição',
                items: _meals.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _selectedMeal = v),
              ),
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
                    final food = (_selectedFood ?? '').trim();
                    if (food.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selecione o alimento')),
                      );
                      return;
                    }
                    final grams = double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 0;
                    if (grams <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Informe o peso em gramas')),
                      );
                      return;
                    }
                    final perGram = FoodCalories.perGram(food);
                    int calories;
                    if (perGram != null) {
                      calories = (grams * perGram).round();
                    } else {
                      calories = context.read<MealProvider>().estimateForName(food);
                    }
                    context.read<MealProvider>().addMeal(
                          dateTime: DateTime.now(),
                          name: food,
                          calories: calories,
                        );
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      context.go(AppRoutes.home);
                    });
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
  const _RoundedField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

class _RoundedDropdown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  const _RoundedDropdown({required this.value, required this.hint, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEDEDED),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
    );
  }
}


