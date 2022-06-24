import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spetyfalc/src/bloc/data_bloc.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/theme/app_color.dart';
import 'package:spetyfalc/src/utils/utils.dart';
import 'package:spetyfalc/src/widget/item_widget.dart';

class CategoryScreen extends StatefulWidget {
  final Function(DataModel data) onTap;

  const CategoryScreen({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isBuy = false;

  @override
  void initState() {
    super.initState();
    _getData();
    dataBloc.getData("");
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return StreamBuilder(
      stream: dataBloc.data,
      builder: (context, AsyncSnapshot<List<DataModel>> snapshot) {
        if (snapshot.hasData) {
          List<DataModel> data = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (_, index) {
              return Container(
                height: 320 * h,
                margin: EdgeInsets.only(bottom: 20 * h),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24 * w),
                      child: Row(
                        children: [
                          Text(
                            data[index].name,
                            style: TextStyle(
                              fontFamily: AppColor.fonts,
                              fontWeight: FontWeight.w600,
                              fontSize: 20 * h,
                              height: 24 / 20 * h,
                              color: AppColor.black49,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              widget.onTap(data[index]);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Text(
                                "Show All",
                                style: TextStyle(
                                  fontFamily: AppColor.fonts,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14 * h,
                                  height: 17 / 14 * h,
                                  color: AppColor.grayAD,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16 * h,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24 * w),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data[index].data.length,
                          itemBuilder: (_, item) {
                            return ItemWidget(
                              h: h,
                              w: w,
                              data: data[index].data[item],
                              blur: isBuy,
                              category: data[index].name,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: Lottie.asset(
              'assets/icons/anim.json',
              height: 100 * h,
              width: 100 * h,
            ),
          );
        }
      },
    );
  }

  _getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isBuy = pref.getBool("ISBUY") ?? false;
    setState(() {});
  }
}
