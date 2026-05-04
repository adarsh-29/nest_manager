import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routs/Routs.dart';
import '../provider/OtpProvider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OtpProvider>().startTimer();
    });
  }

  String getOtp() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OtpProvider>();

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
              ///  Back
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text(
                    "Back to Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              ///  Icon
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.grid_view, color: Colors.orange, size: 32),
              ),

              const SizedBox(height: 20),

              const Text(
                "Verify OTP",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Sent to +91 98765 43210",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              /// Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    ///  OTP Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 45,
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    ///  Error
                    if (provider.error != null)
                      Text(provider.error!, style: const TextStyle(color: Colors.red)),

                    const SizedBox(height: 10),

                    ///  Verify Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                          String otp = getOtp();

                          if (otp.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter complete OTP")),
                            );
                            return;
                          }

                          bool success = await context
                              .read<OtpProvider>()
                              .verifyOtp(otp);

                          if (success) {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const  MainDashboardScreen(),
                              ),
                            );*/

                            Navigator.pushReplacementNamed(context, AppRoutes.mainDashboard);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: provider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Verify & Continue"),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// ⏱ Resend
                    provider.secondsRemaining > 0
                        ? Text(
                      "Resend in 0:${provider.secondsRemaining.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white70),
                    )
                        : TextButton(
                      onPressed: () {
                        context.read<OtpProvider>().resendOtp();
                      },
                      child: const Text("Resend OTP"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}