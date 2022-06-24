import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spetyfalc/src/bloc/data_bloc.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/utils/utils.dart';
import 'package:spetyfalc/src/widget/column_widget.dart';

class SearchScreen extends StatefulWidget {
  final bool buy;
  const SearchScreen({
    Key? key, required this.buy,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return StreamBuilder(
      stream: dataBloc.data1,
      builder: (context, AsyncSnapshot<List<Category>> snapshot) {
        if (snapshot.hasData) {
          List<Category> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return ColumnWidget(
                h: h,
                w: w,
                buy: widget.buy,
                category: data[index].name,
                data: data[index],
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
}
