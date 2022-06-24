import 'package:flutter/material.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/utils/utils.dart';
import 'package:spetyfalc/src/widget/column_widget.dart';

class ColumnView extends StatefulWidget {
  final DataModel data;
  final bool buy;
  final String category;

  const ColumnView({
    Key? key,
    required this.data,
    required this.buy,
    required this.category,
  }) : super(key: key);

  @override
  State<ColumnView> createState() => _ColumnViewState();
}

class _ColumnViewState extends State<ColumnView> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return ListView.builder(
      itemCount: widget.data.data.length,
      itemBuilder: (_, index) {
        return ColumnWidget(
          h: h,
          w: w,
          buy: widget.buy,
          data: widget.data.data[index],
          category: widget.category,
        );
      },
    );
  }
}
