import 'package:flutter/material.dart';

class BarometerProvider with ChangeNotifier {
  double _previousReading = 0;
  double _pZero = 0;

  double get pZero {
    // _pZero ??= _previousReading;
    return _pZero;
  }

  double get previousReading {
    return _previousReading;
  }

  void setPreviousReading(double value) {
    _previousReading = value;
  }

  void resetPZeroValue() {
    _pZero = _previousReading;
    notifyListeners();
  }
}
