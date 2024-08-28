import 'package:babycare2/translations/MyTranslations.dart';
import 'package:babycare2/views/BottomNavigigationBarBaby.dart';
import 'package:babycare2/views/LanguageSelectionPage.dart';
import 'package:babycare2/views/MyHomePage.dart';
import 'package:babycare2/views/babys_creen.dart';
import 'package:babycare2/views/infoscreen.dart';
import 'package:babycare2/views/welcome_page/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/ChildInfoController.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? locale = prefs.getString('locale');
  Get.put(ChildInfoController());
  runApp(MyApp(initialLocale: locale));

}
class MyApp extends StatelessWidget {
  final String? initialLocale;

  const MyApp({Key? key, this.initialLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: initialLocale != null ? Locale(initialLocale!) : Locale('ar', 'SA'),
      translations: MyTranslations(),
      getPages: [
        GetPage(name: "/", page: () => welcomepage()),
        GetPage(name: "/MyHomePage", page: () => MyHomePage()),
        GetPage(name: "/LanguageSelectionPage", page: () => LanguageSelectionPage()),
        GetPage(name: "/InfoScreen", page: () => InfoScreen()),
        GetPage(name: "/MianBabyScreenView", page: () => BottomNavigigationBarBaby()),
      ],
    );
  }
}


