import 'package:flutter/material.dart';
import 'package:parallel_farm/models/eggs_data.dart';

class RedeemedEggsProvider extends ChangeNotifier {
  RedeemedEggsData? _data;

  RedeemedEggsData? get data => _data;

  void setData(RedeemedEggsData newData) {
    _data = newData;
    notifyListeners();
  }
}