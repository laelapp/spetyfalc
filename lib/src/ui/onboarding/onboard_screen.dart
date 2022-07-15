//import 'package:apphud/apphud.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spetyfalc/src/model/onboard_model.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/ui/main/main_screen.dart';
import 'package:spetyfalc/src/ui/settings/web_view.dart';
import 'package:spetyfalc/src/utils/utils.dart';

class OnBoardScreen extends StatefulWidget {
  final int index;

  const OnBoardScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController? _controller;
  bool isBuy = false;

  final InAppReview inAppReview = InAppReview.instance;

  List<OnBoardModel> data = [
    OnBoardModel(
      msg: 'Get access to some really cool content',
      image: 'assets/images/img_1.png',
      title: 'Special content for you',
    ),
    OnBoardModel(
      msg: 'We promise to surprise you with new functionality update',
      image: 'assets/images/img_2.png',
      title: 'Help us become better',
    ),
    OnBoardModel(
      msg: 'Attract followers and create quality content',
      image: 'assets/images/img_3.png',
      title: 'Become popular or leader',
    ),
    OnBoardModel(
      msg:
          'Subscribe now to unlock all the features of our app, just \$7.99 per week',
      image: 'assets/images/img_4.png',
      title: 'Lets Go to our Special content',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: widget.index,
    );
  }

  int select = 0;

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/onboard_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 42 * h,
              ),
              Expanded(
                child: PageView.builder(
                  physics: widget.index == 0
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) async {
                    select = index;
                    setState(() {});
                    if (index == 1) {
                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      }
                    }
                  },
                  controller: _controller,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16 * w,
                                  right: index == 3 ? 0 : 16 * w,
                                  top: 32),
                              child: Image.asset(
                                data[index].image,
                                height: 280 * h,
                              ),
                            ),
                            SizedBox(
                              height: 85 * h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 24 * w),
                              child: Text(
                                data[index].title.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppColor.fonts,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 24 * h,
                                  height: 1.45 * h,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15 * h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 16 * w),
                              child: Text(
                                data[index].msg,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppColor.fonts,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 17 * h,
                                  height: 1.45 * h,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 28 * h,
                          right: 24 * w,
                          child: index == 3
                              ? GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool("ISFIRST", true);
                                    isBuy = false;
                                    prefs.setBool("ISBUY", isBuy);
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen(),
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/close.svg",
                                    height: 24,
                                    width: 24,
                                    color: AppColor.dark00.withOpacity(0.15),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: 56 * h,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 24 * h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(36 * h),
                    onTap: () async {
                      if (_controller!.page!.toInt() < 3) {
                        _controller!.animateToPage(
                          (_controller!.page! + 1).toInt(),
                          duration: const Duration(milliseconds: 270),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        if (await Apphud.hasActiveSubscription()) {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
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
                        } else {
                          var paywalls = await Apphud.paywalls();
                          print("Test1");
                          print(paywalls?.paywalls.first.products!.first);
                          await Apphud.purchase(
                              product:
                              paywalls?.paywalls.first.products!.first);
                          print("Test2");
                          if (await Apphud.hasActiveSubscription()) {
                            print("Test3");
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setBool("ISFIRST", true);
                            isBuy = true;
                            prefs.setBool("ISBUY", isBuy);
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                          print("Test4");
                        }
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: AppColor.fonts,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 18 * h,
                            color: const Color(0xFF4BADEA),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35 * h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  GestureDetector(
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
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Terms of Use ',
                        style: TextStyle(
                          fontFamily: AppColor.fonts,
                          decoration: TextDecoration.underline,
                          color: AppColor.white.withOpacity(0.3),
                          fontSize: 14 * h,
                          height: 1.4 * h,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 9,
                    width: 0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: AppColor.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      checkRestore(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Restore',
                        style: TextStyle(
                          fontFamily: AppColor.fonts,
                          decoration: TextDecoration.underline,
                          color: AppColor.white.withOpacity(0.3),
                          fontSize: 14 * h,
                          height: 1.4 * h,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 9,
                    width: 0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: AppColor.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
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
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Privacy policy',
                        style: TextStyle(
                          fontFamily: AppColor.fonts,
                          decoration: TextDecoration.underline,
                          color: AppColor.white.withOpacity(0.3),
                          fontSize: 14 * h,
                          height: 1.4 * h,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 32 * h,
              ),
            ],
          ),
        ],
      ),
    );
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
          content: const Text('Your subscription is not found.'),
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
