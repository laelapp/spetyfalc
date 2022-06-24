import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spetyfalc/src/bloc/data_bloc.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/ui/create/create_screen.dart';
import 'package:spetyfalc/src/ui/main/category_screen.dart';
import 'package:spetyfalc/src/ui/main/column_view.dart';
import 'package:spetyfalc/src/ui/main/search_screen.dart';
import 'package:spetyfalc/src/ui/onboarding/onboard_screen.dart';
import 'package:spetyfalc/src/ui/settings/settings_screen.dart';
import 'package:spetyfalc/src/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController controller = TextEditingController();
  DataModel? dataModel;
  bool view = false;
  bool isBuy = false;

  @override
  void initState() {
    super.initState();
    _getData();
    controller.addListener(() {
      dataBloc.getSearch(controller.text);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return WillPopScope(
      onWillPop: () {
        if (view || controller.text.isNotEmpty) {
          view = false;
          controller.text = "";

          setState(() {});
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Column(
          children: [
            SizedBox(
              height: 180 * h,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox(
                    height: 152 * h,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/bg_bar.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 64 * h,
                    left: 24 * w,
                    right: 24 * w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        view
                            ? GestureDetector(
                                onTap: () {
                                  view = false;
                                  setState(() {});
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 24 * h,
                                    color: AppColor.white,
                                  ),
                                ),
                              )
                            : Container(),
                        Text(
                          view ? dataModel!.data[0].name : "Guides",
                          style: TextStyle(
                            fontFamily: AppColor.fonts,
                            fontWeight: FontWeight.w600,
                            fontSize: 28 * h,
                            height: 34 / 28 * h,
                            color: AppColor.white,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            isBuy
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateScreen(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OnBoardScreen(index: 3),
                                    ),
                                  );
                          },
                          child: Container(
                            height: 28 * h,
                            width: 28 * w,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              "assets/icons/add_icon.svg",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24 * w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 28 * h,
                            width: 28 * w,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              "assets/icons/settings.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 126 * h,
                    left: 24 * w,
                    right: 24 * w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14 * w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                        border: Border.all(
                          width: 1,
                          color: AppColor.grayD9,
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontFamily: AppColor.fonts,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * h,
                              color: AppColor.black4B.withOpacity(0.5),
                            ),
                            suffixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.text.isNotEmpty
                  ? SearchScreen(
                      buy: isBuy,
                    )
                  : view
                      ? ColumnView(
                          data: dataModel!,
                          buy: isBuy,
                          category: dataModel!.data[0].name,
                        )
                      : CategoryScreen(
                          onTap: (DataModel data) {
                            dataModel = data;
                            view = true;
                            setState(() {});
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  _getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isBuy = pref.getBool("ISBUY") ?? false;
    setState(() {});
  }
}
