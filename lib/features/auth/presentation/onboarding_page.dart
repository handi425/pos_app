import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_controller.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Admin');
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _isLoading = true);
    await ref
        .read(authControllerProvider.notifier)
        .completeOnboarding(
          name: _nameController.text.trim(),
          pin: _pinController.text.trim(),
        );
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Akun admin dibuat, silakan masuk.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16;

    return Scaffold(
      appBar: AppBar(title: const Text('Setup Awal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selamat datang di KasPOS',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Buat akun admin dan PIN untuk mulai menggunakan aplikasi.',
              ),
              SizedBox(height: spacing),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Admin'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: spacing),
              TextFormField(
                controller: _pinController,
                decoration: const InputDecoration(labelText: 'PIN (4-6 angka)'),
                obscureText: true,
                maxLength: 6,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan PIN';
                  }
                  if (value.length < 4) {
                    return 'PIN minimal 4 angka';
                  }
                  return null;
                },
              ),
              SizedBox(height: spacing),
              TextFormField(
                controller: _confirmPinController,
                decoration: const InputDecoration(labelText: 'Konfirmasi PIN'),
                obscureText: true,
                maxLength: 6,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != _pinController.text) {
                    return 'PIN tidak sama';
                  }
                  return null;
                },
              ),
              SizedBox(height: spacing * 1.5),
              FilledButton(
                onPressed: _isLoading ? null : _handleSubmit,
                child: _isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan dan Lanjutkan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
