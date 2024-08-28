 import 'package:babycare2/model/bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 class AppData {
   AppData._();

   static List<BottomNavigationItem> bottomNavigationItems = [
       BottomNavigationItem(Icon(Icons.home), 'Home'.tr),
     BottomNavigationItem(Icon(Icons.bar_chart), 'Chart'.tr),

     BottomNavigationItem(Icon(Icons.home), 'book'.tr),
     // const BottomNavigationItem(
     //     Icon(Icons.add_shopping_cart_rounded), 'Shopping cart'),
     // const BottomNavigationItem(Icon(Icons.bookmark), 'Favorite'),
     // const BottomNavigationItem(Icon(Icons.person), 'Profile')
   ];
 }