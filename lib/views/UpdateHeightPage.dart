// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:babycare2/controller/ChildInfoController.dart';
//
// class UpdateHeightPage extends StatelessWidget {
//   final ChildInfoController controller = Get.find();
//   final TextEditingController heightController = TextEditingController();
//   final Rx<DateTime> selectedDate = DateTime.now().obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Height'.tr),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: selectedDate.value,
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 );
//                 if (pickedDate != null) {
//                   selectedDate.value = pickedDate;
//                 }
//               },
//               child: Obx(() {
//                 return TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Select Date'.tr,
//                     hintText: DateFormat('yyyy-MM-dd').format(selectedDate.value),
//                     prefixIcon: Icon(Icons.calendar_today, color: Colors.cyanAccent),
//                     border: OutlineInputBorder(),
//                   ),
//                   readOnly: true,
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: heightController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter Height'.tr,
//                 prefixIcon: Icon(Icons.height, color: Colors.cyanAccent),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (heightController.text.isNotEmpty) {
//                   double newHeight = double.parse(heightController.text);
//                   DateTime date = selectedDate.value;
//
//                   // Save the height and date to the database
//                   controller.updateHeightWithDate(newHeight, date);
//                   Get.back(); // Navigate back after saving
//                 } else {
//                   Get.snackbar(
//                     'Error',
//                     'Please enter a height value'.tr,
//                     snackPosition: SnackPosition.BOTTOM,
//                   );
//                 }
//               },
//               child: Text('Save'.tr),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
