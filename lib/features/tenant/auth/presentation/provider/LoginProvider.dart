import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{

  bool isLoading = false;
  String? error;

  Future<bool> login(String phone, String password, String role) async {
    isLoading = true;
    error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // Dummy condition
    if (phone == "9999999999" && password == "123456") {
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      error = "Invalid credentials";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

}