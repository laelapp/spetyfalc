// ignore_for_file: use_build_context_synchronously

import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/ui/main/main_screen.dart';
import 'package:spetyfalc/src/ui/onboarding/onboard_screen.dart';
import 'package:spetyfalc/src/ui/settings/web_view.dart';
import 'package:spetyfalc/src/utils/utils.dart';
import 'package:spetyfalc/src/widget/settings_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isBuy = false;

  void intState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          SizedBox(
            height: 120 * h,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SizedBox(
                  height: 122 * h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/bg_bar.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 64 * h,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Settings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.w600,
                      fontSize: 28 * h,
                      height: 34 / 28 * h,
                      color: AppColor.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 74 * h,
                  left: 24 * w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(14 * h),
            margin: EdgeInsets.symmetric(horizontal: 24 * w, vertical: 24 * h),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                isBuy
                    ? Container()
                    : SettingsWidget(
                        name: "Subscribe premium \$7.99",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OnBoardScreen(index: 3),
                            ),
                          );
                        },
                        view: true,
                        line: false,
                      ),
                SettingsWidget(
                  name: "Privacy Policy",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WebViewScreen(
                          url:
                              "https://docs.google.com/document/d/18BBg0XDtEZkf2V-KgRjHKy-aucIoO-SrEjDK6NWUePw/edit?usp=sharing",
                        ),
                      ),
                    );
                  },
                  view: false,
                  line: false,
                ),
                SettingsWidget(
                  name: "Terms of Use",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WebViewScreen(
                          url:
                              "https://docs.google.com/document/d/1zXJpJ2ng0a43VZZjCHRxHdGbo_sr50QzkZR03HJ12Hs/edit?usp=sharing",
                        ),
                      ),
                    );
                  },
                  line: false,
                  view: false,
                ),
                SettingsWidget(
                  name: "Restore Purchase",
                  onTap: () {
                    checkRestore(context);
                  },
                  line: true,
                  view: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isBuy = pref.getBool("ISBUY") ?? false;
    setState(() {});
  }

  void checkRestore(context) async {
    var bool = await Apphud.hasActiveSubscription();
    if (bool) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success!'),
          content: const Text('Your subscription has been restored!'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("ISFIRST", true);
                isBuy = true;
                prefs.setBool("ISBUY", isBuy);
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Restore subscription'),
          content: const Text(
              'Your subscription is not found.'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }
}
