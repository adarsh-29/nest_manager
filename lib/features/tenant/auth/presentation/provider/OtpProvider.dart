import 'dart:async';

import 'package:flutter/cupertino.dart';


class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;

  int secondsRemaining = 30;
  Timer? _timer;

  void startTimer() {
    secondsRemaining = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  Future<bool> verifyOtp(String otp) async {
    isLoading = true;
    error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (otp == "123456") {
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      error = "Invalid OTP";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void resendOtp() {
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}