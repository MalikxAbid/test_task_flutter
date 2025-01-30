import 'package:flutter/material.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CAppBar({super.key, required this.title, this.actions, this.titleColor, this.leading, this.subtTitle});

  final String title;
  final String? subtTitle;
  final List<Widget>? actions;
  final Color? titleColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.white,
      leading: leading,
      centerTitle: true,
      title: CText(
        text: title,
        color: AppColor.black,
        fontsize: getResponsiveHeight(context, 24),
        fontWeight: FontWeight.bold,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
