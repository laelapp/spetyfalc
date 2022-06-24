// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spetyfalc/src/bloc/data_bloc.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/ui/onboarding/onboard_screen.dart';
import 'package:spetyfalc/src/utils/utils.dart';
import 'package:spetyfalc/src/widget/center_dialog/center_dialog.dart';

class ViewScreen extends StatefulWidget {
  final Category data;

  const ViewScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  bool like = false;
  bool isBuy = false;
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 64 * h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24 * w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.blueFF,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    CenterDialog.centerDialogReport(
                      context,
                      () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool(
                            "Block${widget.data.subTitle}${widget.data.title}",
                            true);
                        CenterDialog.centerDialogSubmit(
                          context,
                          () {
                            dataBloc.getData("");
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      "assets/icons/alert.svg",
                    ),
                  ),
                ),
                SizedBox(
                  width: 12 * w,
                ),
                GestureDetector(
                  onTap: () async {
                    if (isBuy) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool(
                          "Like${widget.data.name}${widget.data.title}", !like);
                      like = !like;
                      dataBloc.getData("");
                      setState(() {});
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnBoardScreen(index: 3),
                        ),
                      );
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      like
                          ? "assets/icons/like_click.svg"
                          : "assets/icons/like.svg",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20 * h,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24 * w),
                  child: Text(
                    widget.data.title,
                    style: TextStyle(
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.w600,
                      fontSize: 24 * h,
                      height: 1.45 * h,
                      color: AppColor.dark00,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16 * h,
                ),
                Container(
                  height: 170 * h,
                  color: Colors.transparent,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: widget.data.image.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 170 * h,
                        width: 240 * w,
                        margin: EdgeInsets.only(right: 20 * w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: widget.data.name == "My Guides"
                              ? Image.memory(
                                  Uint8List.fromList(
                                    widget.data.image[index].codeUnits,
                                  ),
                                  fit: BoxFit.cover,
                                  height: 170 * h,
                                  width: 240 * w,
                                )
                              : Image.network(
                                  widget.data.image[index],
                                  fit: BoxFit.cover,
                                  height: 170 * h,
                                  width: 240 * w,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 18 * h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24 * w),
                  padding: EdgeInsets.only(left: 8 * w),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: Color(0xFF45A4ED),
                      ),
                    ),
                  ),
                  child: Text(
                    widget.data.subTitle,
                    style: TextStyle(
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.w600,
                      fontSize: 18 * h,
                      height: 1.5 * h,
                      color: AppColor.dark00,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6 * h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24 * w),
                  child: Text(
                    widget.data.description,
                    style: TextStyle(
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.w400,
                      fontSize: 14 * h,
                      height: 1.5 * h,
                      color: AppColor.black49,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    like = preferences.getBool("Like${widget.data.name}${widget.data.title}") ??
        false;
    isBuy = preferences.getBool("ISBUY") ?? false;
    setState(() {});
  }
}
