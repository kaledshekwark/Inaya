import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _changeLanguage('en', 'US');
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _changeLanguage('ar', 'SA');
              },
              child: Text('العربية'),
            ),
          ],
        ),

    );
  }

  Future<void> _changeLanguage(String languageCode, String countryCode) async {
    Locale locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', languageCode);
  }
}