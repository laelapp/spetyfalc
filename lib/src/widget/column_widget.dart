import 'dart:typed_data';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/ui/onboarding/onboard_screen.dart';
import 'package:spetyfalc/src/ui/view/view_screen.dart';

class ColumnWidget extends StatelessWidget {
  final double h;
  final double w;
  final Category data;
  final bool buy;
  final String category;

  const ColumnWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.data,
    required this.buy,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => buy || category != "Premium"
                ? ViewScreen(data: data)
                : const OnBoardScreen(index: 3),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(14 * h),
        margin: EdgeInsets.only(left: 24 * w, right: 24 * w, bottom: 16 * h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.white,
          border: Border.all(
            width: 1,
            color: AppColor.grayD9,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 134 * h,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: data.name == "My Guides"
                    ? data.image.isNotEmpty
                        ? Image.memory(
                            Uint8List.fromList(data.image[0].codeUnits),
                            fit: BoxFit.cover,
                          )
                        : Container()
                    : data.image.isEmpty
                        ? Container()
                        : buy && category == "Premium"
                            ? Stack(
                                children: [
                                  Image.network(
                                    data.image[0],
                                    fit: BoxFit.cover,
                                    height: 134 * h,
                                  ),
                                  Positioned(
                                    top: 10 * h,
                                    right: 10 * h,
                                    child: Container(
                                      height: 32 * w,
                                      width: 32 * w,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: AppColor.blueFF,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/king.svg",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : category == "Premium"
                                ? SizedBox(
                                    height: 135 * h,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      data.image[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ).blurred(
                                    blur: 1,
                                    blurColor:
                                        const Color.fromRGBO(0, 0, 0, 0.5),
                                    overlay: Container(
                                      height: 74 * h,
                                      width: 74 * h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColor.blueFF,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/icons/lock.svg",
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.network(
                                    data.image[0],
                                    fit: BoxFit.cover,
                                  ),
              ),
            ),
            SizedBox(
              height: 14 * h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                data.title,
                style: TextStyle(
                  fontFamily: AppColor.fonts,
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * h,
                  height: 1.4 * h,
                  color: AppColor.dark00,
                ),
              ),
            ),
            SizedBox(
              height: 8 * h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                data.subTitle,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppColor.fonts,
                  fontWeight: FontWeight.w500,
                  fontSize: 14 * h,
                  height: 1.45 * h,
                  color: AppColor.grayAD,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
