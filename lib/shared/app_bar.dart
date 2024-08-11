import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

// ignore: constant_identifier_names
enum LeftIconType { CLOSE, BACK, LOGO }

Map<LeftIconType, String> leftIconAsset = {
  LeftIconType.CLOSE: 'assets/icons/close.svg',
  LeftIconType.BACK: 'assets/icons/chevron_left.svg',
  LeftIconType.LOGO: 'assets/icons/logo.svg',
};

class AppBarLeft {
  final String? label;
  final LeftIconType? iconType;
  final VoidCallback? onTap;

  AppBarLeft({
    this.label,
    this.iconType = LeftIconType.BACK,
    this.onTap,
  });
}

class AppBarCenter {
  final String label;

  AppBarCenter({
    required this.label,
  });
}

class RightIcon {
  RightIcon({required this.name, required this.onTap});
  final String name;
  final VoidCallback onTap;
}

class AppBarRight {
  final String? label;
  final List<RightIcon>? icons;

  AppBarRight({
    this.label,
    this.icons,
  });
}

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final AppBarLeft? leftOptions;
  final AppBarCenter? centerOptions;
  final AppBarRight? rightOptions;

  const SharedAppBar({
    super.key,
    this.bottom,
    this.actions,
    this.leftOptions,
    this.centerOptions,
    this.rightOptions,
  });

  // ignore: non_constant_identifier_names
  Widget? Left(BuildContext context) {
    String iconAsset = leftOptions?.iconType != null
        ? leftIconAsset[leftOptions?.iconType]!
        : '';
    return Positioned(
      left: 0,
      height: 26,
      child: Align(
        alignment: Alignment.center,
        child: leftOptions!.label != null
          ? Head2(value: leftOptions!.label!)
          : GestureDetector(
              onTap: leftOptions?.onTap ?? () => {Get.back()},
              child: SvgPicture.asset(iconAsset,
              colorFilter: leftOptions?.iconType == LeftIconType.LOGO
                  ? null
                      : ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn)),
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget? CenterPart(BuildContext context) {
    return Positioned(
      child: Container(
        height: kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
        child: Center(
            child: Body1(
          value: centerOptions!.label,
          bold: true,
        )),
      ),
      //child: Center(),
    );
  }

// ignore: non_constant_identifier_names
  Widget? Right(BuildContext context) {
    return Positioned(
      right: 0,
      child: rightOptions!.label != null
          ? Head2(value: rightOptions!.label!)
          : Wrap(
              spacing: 16,
              children: rightOptions!.icons!
                  .map((asset) => GestureDetector(
                        onTap: asset.onTap,
                        child: SvgPicture.asset(
                          'assets/icons/${asset.name}.svg',
                        width: 24,
                        colorFilter:
                            ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn),
                        ),
                      ))
                  .toList(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (leftOptions != null) children.add(Left(context)!);
    if (centerOptions != null) children.add(CenterPart(context)!);
    if (rightOptions != null) children.add(Right(context)!);

    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 56,
      child: Stack(
        children: children,
      ),
    ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
