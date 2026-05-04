
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routs/Routs.dart';
import '../provider/LoginProvider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isOwner = true;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F3E6A), Color(0xFF2E6FA3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// Logo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.home, size: 40, color: Colors.orange),
              ),

              const SizedBox(height: 16),

              const Text(
                "NestManager",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const Text(
                "Property Management Platform",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        ///  Toggle
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              _toggle("Owner", true),
                              _toggle("Tenant", false),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        ///  Phone Field
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          maxLength: 10,
                          decoration: _inputDecoration("Mobile Number", "+91 9876543210", Icons.phone),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter mobile number";
                            }
                            if (value.length < 10) {
                              return "Invalid number";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        ///  Password Field
                        TextFormField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration(
                            "Password",
                            "••••••••",
                            Icons.lock,
                            suffix: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            if (value.length < 6) {
                              return "Minimum 6 characters";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        ///  Error
                        if (provider.error != null)
                          Text(
                            provider.error!,
                            style: const TextStyle(color: Colors.red),
                          ),

                        const SizedBox(height: 10),

                        ///  Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: provider.isLoading
                                ? null
                                : () async {
                              if (_formKey.currentState!.validate()) {
                                bool success = await context
                                    .read<LoginProvider>()
                                    .login(
                                  phoneController.text,
                                  passwordController.text,
                                  isOwner ? "owner" : "tenant",
                                );

                                if (success) {
                                 /* Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const  OtpScreen(),
                                    ),
                                  );*/

                                  Navigator.pushReplacementNamed(context, AppRoutes.otp);

                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                : const Text("Login →"),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          "Forgot password? Reset via OTP",
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Toggle Widget
  Widget _toggle(String text, bool value) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOwner = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isOwner == value ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isOwner == value ? Colors.blue : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  /// Input Decoration
  InputDecoration _inputDecoration(String label, String hint, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}