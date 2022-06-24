import 'package:flutter/material.dart';
import 'package:spetyfalc/src/theme/app_color.dart';

class SettingsWidget extends StatelessWidget {
  final String name;
  final bool view;
  final bool line;
  final Function() onTap;

  const SettingsWidget({
    Key? key,
    required this.name,
    required this.onTap,
    required this.view,
    required this.line,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: AppColor.fonts,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.4,
                      color: view ? AppColor.blueFF : AppColor.dark00,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: view ? AppColor.blueFF : const Color(0xFFA6A6A6),
                  size: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            line
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: const Color(0xFFE6E6E6),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
