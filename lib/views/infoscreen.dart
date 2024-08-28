
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  static const String routeName = "infoview";

  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  _launchURL(int i) async {
    List<String> urls = [
      'https://www.linkedin.com/in/khaled-shek-wark-725323262?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      'https://github.com/kaledshekwark',
      'https://www.facebook.com/kalad.shekwark?mibextid=ZbWKwL',
      "",
      "",
      "https://twitter.com/",
    ];
    // ignore: deprecated_member_use
    // if (await canLaunch(urls[i])) {
    //   // ignore: deprecated_member_use
    //   await launch(urls[i]);
    // } else {
    //   throw 'Could not launch $urls[i]';
    // }
  }

  @override
  Widget build(BuildContext context) {
    // late AppController provider = Provider.of<AppController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          'َBaby Care'.tr,
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,

        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                // color: ThemeDataProvider.mainAppColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: SizedBox(
                  //     child: CircleAvatar(
                  //       backgroundColor: Colors.transparent,
                  //       // foregroundColor: ThemeDataProvider.mainAppColor,
                  //       radius: MediaQuery.of(context).size.width * 0.12,
                  //       child: Image.asset(
                  //         "assets/images/logo.png",
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),

                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "`وَأَنَّ سَعْيَهُۥ سَوْفَ يُرَىٰ`",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,

                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            settings(context),
            const SizedBox(height: 10),
            about(context),
            const SizedBox(height: 10),
            developers(context),
            const SizedBox(height: 20),
            supervisor(context),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(

                  'RightsReserved'.tr
                ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(

                   'version'.tr),

              ),

          ]),
        ),
      ),
    );
  }

  Widget developers(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
         leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.person,

              size: 24,
            ),
          ),
        ),
        title: Text(
           "Developers".tr

        ),
        children: <Widget>[
          Column(
            mainAxisAlignment:MainAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text(
                      'Eng.khaled'.tr ,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   child: Text(
                    //     provider.isEnglish()
                    //         ? ". Flutter Developer"
                    //         : ". مبرمج تطبيقات",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //       fontFamily: "quranFont",
                    //       color: provider.isDarkTheme()
                    //           ? ThemeDataProvider.textDarkThemeColor
                    //           : ThemeDataProvider.textLightThemeColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  textAlign: TextAlign.justify,

                   'Software_engineer'.tr

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchURL(0);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      color: Color(0xff0E76A8),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(1);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.github,

                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(4);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.bugs,
                      color: Color(0xFF89dad0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(3);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Color(0xff25d366),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(2);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Color(0xff3b5998),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL(5);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Color(0xff1DA1F2),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget about(BuildContext context) {
    // late AppController provider = Provider.of<AppController>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
        // iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.info_outline,
               size: 24,
            ),
          ),
        ),
        title: Text(
          "About".tr  ,


        ),
        children: <Widget>[
          Column(
            mainAxisAlignment:
                  MainAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                "َBaby Care".tr  ,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,


                  ),
                ),
              ),
              ListTile(
                title: Text(
                  textAlign: TextAlign.justify,

                       'Tracker app to help you track your baby’s growth.'.tr

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget supervisor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.info_outline,
              size: 24,
            ),
          ),
        ),
        title: Text(
          "Application content supervisor".tr,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Dr.Moamena alshekh wark".tr,
              style: TextStyle(fontSize: 18), // Optional: adjust the text style
            ),
          ),
        ],
      ),
    );
  }

  Widget settings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ExpansionTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 245, 241, 241),
          ),
          child: const Center(
            child: Icon(
              Icons.settings,
              size: 24,
            ),
          ),
        ),
        title: Text(
          "Settings".tr,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Language".tr,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      CupertinoSwitch(
                        value: Get.locale?.languageCode == 'en' ? true : false,
                        onChanged: (value) async {
                          if (value) {
                            await _changeLanguage('en', 'US');
                          } else {
                            await _changeLanguage('ar', 'SA');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

            ],
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
Future<void> _changeLanguage(String languageCode, String countryCode) async {
  Locale locale = Locale(languageCode, countryCode);
  Get.updateLocale(locale);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('locale', languageCode);
}