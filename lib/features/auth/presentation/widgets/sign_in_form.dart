import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class SignInForm extends ConsumerStatefulWidget {
  final VoidCallback? onForgotPassword;
  
  const SignInForm({
    super.key,
    this.onForgotPassword,
  });

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            
            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Password field
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outlined),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            const SizedBox(height: 8),

            // Forgot password link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.onForgotPassword,
                child: const Text('Forgot Password?'),
              ),
            ),

            const SizedBox(height: 24),

            // Sign in button
            ElevatedButton(
              onPressed: authState.maybeWhen(
                loading: () => null,
                orElse: () => _signIn,
              ),
              child: const Text('Sign In'),
            ),

            const SizedBox(height: 16),

            // Link anonymous account option (if user is anonymous)
            Consumer(
              builder: (context, ref, child) {
                final isAnonymous = ref.watch(isAnonymousProvider);
                if (!isAnonymous) return const SizedBox.shrink();

                return Column(
                  children: [
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Link your anonymous account',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Save your data by linking your anonymous account to an email',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: authState.maybeWhen(
                          loading: () => null,
                          orElse: () => _linkAccount,
                        ),
                        icon: const Icon(Icons.link),
                        label: const Text('Link Account'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(authNotifierProvider.notifier).signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _linkAccount() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(authNotifierProvider.notifier).linkWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }
}