import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChildInfoController extends GetxController {
  var name = ''.obs;
  var birthdate = DateTime.now().obs;
  var gender = ''.obs;
  RxInt currentBottomNavItemIndex = 0.obs;
  RxInt currentPageViewItemIndicator = 0.obs;

  switchBetweenBottomNavigationItems(int currentIndex)  {
    currentBottomNavItemIndex.value = currentIndex;
  }

  switchBetweenPageViewItems(int currentIndex) {
    currentPageViewItemIndicator.value = currentIndex;
  }
  @override
  void onInit() {
    super.onInit();
    loadChildInfo();
  }

  void saveChildInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name.value);
    await prefs.setString('birthdate', birthdate.value.toIso8601String());
    await prefs.setString('gender', gender.value);
  }

  void loadChildInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    String? birthdateString = prefs.getString('birthdate');
    if (birthdateString != null) {
      birthdate.value = DateTime.parse(birthdateString);
    }
    gender.value = prefs.getString('gender') ?? '';
  }
}
