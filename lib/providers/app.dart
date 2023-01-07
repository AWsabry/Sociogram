import 'package:flutter/material.dart';

enum SearchBy { Users }

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  SearchBy search = SearchBy.Users;
  String filterBy = "Users";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({required SearchBy newSearchBy}) {
    search = newSearchBy;
    if (newSearchBy == SearchBy.Users) {
      filterBy = "Users";
    }
    notifyListeners();
  }
}
