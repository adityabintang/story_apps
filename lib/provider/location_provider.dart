import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  String? _selectedLocation;

  String? get selectedLocation => _selectedLocation;

  void setSelectedLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }
}