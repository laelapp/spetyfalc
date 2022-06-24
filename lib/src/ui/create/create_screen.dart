// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spetyfalc/src/bloc/data_bloc.dart';
import 'package:spetyfalc/src/database/database_helper.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/model/image_model.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/utils/utils.dart';
import 'package:spetyfalc/src/widget/center_dialog/center_dialog.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController postController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<XFile> pickerList = [];
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
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
                    "Create Post",
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
          SizedBox(
            height: 24 * h,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24 * w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * w, vertical: 6 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.white,
                    border: Border.all(
                      width: 1,
                      color: AppColor.grayAD,
                    ),
                  ),
                  child: TextField(
                    controller: titleController,
                    maxLength: 60,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontFamily: AppColor.fonts,
                        fontWeight: FontWeight.w400,
                        fontSize: 16 * h,
                        color: AppColor.black49,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20 * h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24 * w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * w, vertical: 6 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.white,
                    border: Border.all(
                      width: 1,
                      color: AppColor.grayAD,
                    ),
                  ),
                  child: TextField(
                    controller: subTitleController,
                    maxLength: 80,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Subtitle",
                      hintStyle: TextStyle(
                        fontFamily: AppColor.fonts,
                        fontWeight: FontWeight.w400,
                        fontSize: 16 * h,
                        color: AppColor.black49,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20 * h,
                ),
                Container(
                  height: 300 * h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24 * w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * w, vertical: 6 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.white,
                    border: Border.all(
                      width: 1,
                      color: AppColor.grayAD,
                    ),
                  ),
                  child: TextField(
                    controller: postController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Post",
                      hintStyle: TextStyle(
                        fontFamily: AppColor.fonts,
                        fontWeight: FontWeight.w400,
                        fontSize: 16 * h,
                        color: AppColor.black49,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20 * h,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (pickerList.length < 5) {
                        XFile? p = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 30,
                        );
                        pickerList.add(p!);
                        setState(() {});
                      } else {
                        CenterDialog.showCenterPicture(context);
                      }
                    } catch (_) {}
                  },
                  child: Container(
                    height: 50 * h,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24 * w),
                    padding: EdgeInsets.symmetric(horizontal: 14 * w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.white,
                      border: Border.all(
                        width: 1,
                        color: AppColor.grayAD,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          " Images",
                          style: TextStyle(
                            fontFamily: AppColor.fonts,
                            fontWeight: FontWeight.w400,
                            fontSize: 16 * h,
                            color: AppColor.black49,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 24 * w,
                          width: 24 * w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFF25BBFD),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: AppColor.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14 * h,
                ),
                Container(
                  height: pickerList.isEmpty ? 0 : 80 * h,
                  margin: EdgeInsets.only(left: 24 * w),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pickerList.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 80 * w,
                        width: 80 * w,
                        color: Colors.transparent,
                        margin: EdgeInsets.only(right: 12 * w),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(
                                File(pickerList[index].path),
                                fit: BoxFit.cover,
                                height: 72 * w,
                                width: 72 * w,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  pickerList.removeAt(index);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 16 * w,
                                  width: 16 * w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColor.red,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      color: AppColor.white,
                                      size: 12 * w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    bool networkResult =
                        await InternetConnectionChecker().hasConnection;
                    if (networkResult) {
                      CenterDialog.showCenterDialog(context);
                      List<ImageModel> images = [];
                      for (int i = 0; i < pickerList.length; i++) {
                        Uint8List img =
                            await File(pickerList[i].path).readAsBytes();
                        images.add(
                          ImageModel(
                            id: 0,
                            type: titleController.text.trim() +
                                subTitleController.text.trim(),
                            image: img,
                          ),
                        );
                      }
                      await _databaseHelper.saveImage(images);
                      await _databaseHelper.saveData(
                        Category(
                          id: 0,
                          name: "My Guides",
                          title: titleController.text,
                          subTitle: subTitleController.text,
                          description: postController.text,
                          image: [],
                        ),
                      );
                      dataBloc.getData("");
                    } else {
                      CenterDialog.showCenterNetwork(context);
                    }
                  },
                  child: Container(
                    height: 55 * h,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                        horizontal: 24 * w, vertical: 40 * h),
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
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontFamily: AppColor.fonts,
                          fontWeight: FontWeight.w700,
                          fontSize: 18 * h,
                          color: AppColor.white,
                        ),
                      ),
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
}
