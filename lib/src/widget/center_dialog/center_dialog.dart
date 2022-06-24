import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/widget/center_dialog/field_dialog.dart';

class CenterDialog {
  static void centerDialogReport(BuildContext context, Function() onTap) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          title: FieldDialog(
            onTap: () {
              onTap();
            },
          ),
        );
      },
    );
  }

  static void centerDialogSubmit(BuildContext context, Function() onTap) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          title: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  "assets/icons/submit.svg",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Report Submitted",
                style: TextStyle(
                  fontFamily: AppColor.fonts,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  height: 1.5,
                  color: AppColor.dark00,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onTap();
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2CB5FF),
                        Color(0xFF19C4FA),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontFamily: AppColor.fonts,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showCenterPicture(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            "You can upload up to 5 photos",
            style: TextStyle(
              fontFamily: AppColor.fonts,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              height: 22 / 17,
              color: AppColor.dark00,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      height: 16 / 13,
                      color: Color(0xFF0A84FF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showCenterNetwork(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Ooops! not internet",
            style: TextStyle(
              fontFamily: AppColor.fonts,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              height: 22 / 17,
              color: AppColor.dark00,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      height: 16 / 13,
                      color: Color(0xFF0A84FF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showCenterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Your Guide has been sent successfully for review!",
            style: TextStyle(
              fontFamily: AppColor.fonts,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              height: 22 / 17,
              color: AppColor.dark00,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      height: 16 / 13,
                      color: Color(0xFF0A84FF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
