import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../widget/drawing_area.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawingController extends GetxController {
 RxList<DrawingArea?> points = <DrawingArea?>[].obs;
  var selectedColor = Colors.black.obs;
  var strokeWidth = 2.0.obs;
   var isDarkMode = false.obs;

  void addPoint(DrawingArea? point) {
    points.add(point);
    points.refresh();
    print(points.length);
  }

  void clearPoints() {
    points.clear();
  }

  void changeColor(Color color) {
    selectedColor.value = color;
  }

  void changeStrokeWidth(double width) {
    strokeWidth.value = width;
  }
    void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    saveThemePreference();
  }
    Future<void> saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
  }

  Future<void> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? darkMode = prefs.getBool('isDarkMode');
    if (darkMode != null) {
      isDarkMode.value = darkMode;
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    }
  }
}
