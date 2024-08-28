import 'package:babycare2/Resources/assets_manager.dart';
import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/Resources/dimen_manager.dart';
import 'package:babycare2/Resources/styles_manager.dart';
import 'package:babycare2/controller/ChildInfoController.dart';
import 'package:babycare2/views/LanguageSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final ChildInfoController controller = Get.find( );
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize nameController with the initial value of name
    nameController.text = controller.name.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('baby_care'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // LanguageSelectionPage(),
              Image.asset(AppAssets.onboarding1),
              SizedBox(
                height: AppMargin.m20,
              ),
              TextField(
                controller: nameController,
                onChanged: (value) {
                  controller.name.value = value;
                },
                decoration: InputDecoration(
                  labelText: 'name'.tr,
                  prefixIcon: Icon(Icons.person, color: Colors.cyanAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.birthdate.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    final currentDate = DateTime.now();
                    final age = currentDate.year - pickedDate.year;
                    final ageMonth = currentDate.month - pickedDate.month;
                    final ageDay = currentDate.day - pickedDate.day;
                    if (age > 2 || (age == 2 && (ageMonth > 0 || (ageMonth == 0 && ageDay > 0)))) {
                      // Display error if age is more than 2 years
                      Get.snackbar(
                        'invalid_date'.tr,
                        'child_age_error'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      controller.birthdate.value = pickedDate;
                    }
                  }
                },
                child: AbsorbPointer(
                  child: Obx(() {
                    return TextField(
                      decoration: InputDecoration(
                        labelText: 'birthdate'.tr,
                        hintText: DateFormat('yyyy-MM-dd').format(controller.birthdate.value),
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.cyanAccent),
                        border: OutlineInputBorder(),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(width: 10,),
              Obx(() {
                return DropdownButton<String>(
                  isExpanded: true,
                  value: controller.gender.value.isEmpty ? null : controller.gender.value,
                  hint: Text('select_gender'.tr, style: TextStyle(color: Colors.cyanAccent)),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'male',
                      child: Center(child: Text('male'.tr)),
                    ),
                    DropdownMenuItem<String>(
                      value: 'female',
                      child: Center(child: Text('female'.tr)),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.gender.value = value;
                    }
                  },
                );
              }),
              SizedBox(width: 10,),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (controller.name.value.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'name_error'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else if (controller.birthdate.value == DateTime.now()) {
                    Get.snackbar(
                      'Error',
                      'birthdate_error'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else if (controller.gender.value.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'gender_error'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    controller.saveChildInfo();
                    Get.offAllNamed("/MianBabyScreenView");
                  }
                },
                child: Container(
                  width: Get.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primary,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'save'.tr,
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
