import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/head.dart';

// ignore: constant_identifier_names
enum LeftIconType { CLOSE, BACK, LOGO }

Map<LeftIconType, String> leftIconAsset = {
  LeftIconType.BACK: 'assets/icons/close.svg',
  LeftIconType.CLOSE: 'assets/icons/close.svg',
  LeftIconType.LOGO: 'assets/icons/logo.svg',
};

class AppBarLeft {
  final String? label;
  final LeftIconType? iconType;

  AppBarLeft({
    this.label,
    this.iconType = LeftIconType.BACK,
  });
}

class AppBarCenter {
  final String? label = '';
  final String? subLabel = '';
}

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final AppBarLeft? leftOptions;
  final AppBarCenter? centerOptions;

  const SharedAppBar({
    super.key,
    this.bottom,
    this.actions,
    this.leftOptions,
    this.centerOptions,
  });

  // ignore: non_constant_identifier_names
  Widget? Left(BuildContext context) {
    String iconAsset = leftOptions?.iconType != null
        ? leftIconAsset[leftOptions?.iconType]!
        : '';
    return Container(
      child: leftOptions!.label != null
          ? Head2(value: leftOptions!.label!)
          : SvgPicture.asset(iconAsset,
              colorFilter: leftOptions?.iconType == LeftIconType.LOGO
                  ? null
                  : ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (leftOptions != null) children.add(Left(context)!);

    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 56,
      child: Row(
        children: children,
      ),
    ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
