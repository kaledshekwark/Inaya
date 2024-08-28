import 'package:babycare2/Resources/assets_manager.dart';
import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/Resources/dimen_manager.dart';
import 'package:babycare2/Resources/strings_manager.dart';
import 'package:babycare2/Resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class welcomepage1 extends StatelessWidget {
  const welcomepage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.onboarding1),
        SizedBox(
          height: AppMargin.m20,
        ),
        Text(


          "Track Your Baby’s Growth".tr,
          style: getRegularStyle(color: AppColors.black, fontSize: 20),
        ),
        SizedBox(
          height: AppMargin.m16,
        ),
        Text(
          " Interactive charts showing the process of feeding and breastfeeding a baby. ".tr,
          style: getRegularStyle(fontSize: 15, color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
