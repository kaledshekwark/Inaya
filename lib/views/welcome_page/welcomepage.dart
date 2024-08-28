import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/Resources/dimen_manager.dart';
import 'package:babycare2/Resources/strings_manager.dart';
import 'package:babycare2/Resources/styles_manager.dart';
import 'package:babycare2/controller/welcomepage.dart';
import 'package:babycare2/views/welcome_page/welcomepage1.dart';
import 'package:babycare2/views/welcome_page/welcomepage2.dart';
import 'package:babycare2/views/welcome_page/welcomepage3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class welcomepage extends GetView<welcomepageController> {
  const welcomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final welcomepageController controller =
        Get.put(welcomepageController());
    List<Widget> pages = [welcomepage1(),welcomepage2(),welcomepage3(),];

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppMargin.m20),
            alignment: Alignment.topRight,
            child: Obx(() => TextButton(
                  onPressed: () =>
                      controller.controller.jumpToPage(pages.length),
                  child: controller.isLastPage.value
                      ? Text("")
                      : Text(
                          AppStrings.skip,
                          style: getRegularStyle(
                              fontSize: 18, color: AppColors.black),
                        ),
                )),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: controller.controller,
              onPageChanged: (value) {
                controller.isLastPage.value = (value == 2);
              },
              children: pages,
            ),
          ),
          Obx(() => controller.isLastPage.value
              ? GestureDetector(
                  onTap: () => Get.offNamed('/MyHomePage'),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightPrimary,
                    ),
                    child: Text(
                      AppStrings.done,
                      style: getRegularStyle(
                          color: AppColors.primary, fontSize: 15),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 75,
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmoothPageIndicator(
                        controller: controller.controller,
                        count: 3,
                        effect: WormEffect(
                          dotWidth: 13,
                          dotHeight: 13,
                          activeDotColor: AppColors.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.lightPrimary,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.next,
                            style: getRegularStyle(
                                color: AppColors.primary, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
