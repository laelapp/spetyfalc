import 'package:flutter/material.dart';
import 'package:spetyfalc/src/theme/app_color.dart';

class FieldDialog extends StatefulWidget {
  final Function() onTap;

  const FieldDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  State<FieldDialog> createState() => _FieldDialogState();
}

class _FieldDialogState extends State<FieldDialog> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Report",
              style: TextStyle(
                fontFamily: AppColor.fonts,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.5,
                color: AppColor.dark00,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                child: const Icon(
                  Icons.close,
                  color: AppColor.grayAD,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 182,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1,
              color: AppColor.grayD9,
            ),
          ),
          child: TextField(
            maxLines: null,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your complaint",
              hintStyle: TextStyle(
                fontFamily: AppColor.fonts,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColor.grayAD,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            if (controller.text.isNotEmpty) {
              widget.onTap();
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: controller.text.isEmpty
                  ? const Color(0xFFDFDFDF)
                  : AppColor.blueFF,
            ),
            child: const Center(
              child: Text(
                "Submit Report",
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
    );
  }
}
