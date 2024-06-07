import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  String _bookNumber = '0';
  String _total = '0';
  bool _isVip = false;

  String get bookNumber => _bookNumber;
  String get total => _total;
  bool get isVip => _isVip;

  void setChecked(bool value) {
  _isVip = value;
    notifyListeners();
  }

  void setTotal(double total) {
    _total = total.round().toString();
    notifyListeners();
  }

  void setBookNumber(String bookNumber) {
    _bookNumber = bookNumber;
    notifyListeners();
  }

  void clearData() {
    setBookNumber("0");
    setChecked(false);
    setTotal(0);
  }

  void calculateResult() {
    try {
      double inputNumber = double.parse(_bookNumber);
      double result = inputNumber * 20000;
      if (isVip == true) {
        result = result - result * 10 / 100;
      }
      print("calculating");
      setTotal(result);
    } catch (e) {
      setTotal(0);
    }
  }
}
