import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }
}