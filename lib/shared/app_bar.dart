import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/caption.dart';
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
  final String? caption;

  AppBarCenter({
    required this.label,
    this.caption,
  });
}

class RightIcon {
  RightIcon({required this.name, required this.onTap});
  final String name;
  final VoidCallback onTap;
}

class AppBarRight {
  final String? label;
  final Color? labelColor;
  final VoidCallback? onLabelClick;
  final List<RightIcon>? icons;

  AppBarRight({
    this.label,
    this.icons,
    this.labelColor,
    this.onLabelClick,
  });
}

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final AppBarLeft? leftOptions;
  final AppBarCenter? centerOptions;
  final AppBarRight? rightOptions;

  const SharedAppBar({
    super.key,
    this.bottom,
    this.actions,
    this.color,
    this.leftOptions,
    this.centerOptions,
    this.rightOptions,
  });

  // ignore: non_constant_identifier_names
  Widget? Left(BuildContext context) {
    String iconAsset = leftOptions?.iconType != null
        ? leftIconAsset[leftOptions?.iconType]!
        : '';
    bool isLogo = leftOptions?.iconType == LeftIconType.LOGO;
    return Positioned(
      left: 0,
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: leftOptions!.label != null
            ? Head2(
                value: leftOptions!.label!,
                color: ThemeColor.gray5,
              )
            : GestureDetector(
                onTap: leftOptions?.onTap ?? () => {Get.back()},
                child: SvgPicture.asset(iconAsset,
                    width: isLogo ? 116 : null,
                    colorFilter: isLogo
                        ? null
                        : ColorFilter.mode(ThemeColor.gray4, BlendMode.srcIn)),
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget? CenterPart(BuildContext context) {
    double height = kToolbarHeight + (bottom?.preferredSize.height ?? 0.0);
    if (centerOptions!.caption != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Body1(
              value: centerOptions!.label,
              bold: true,
              maxLength: 15,
            ),
            Caption(value: centerOptions!.caption!)
          ],
        ),
      );
    }

    return Positioned(
      child: SizedBox(
        height: height,
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
      height: 50,
      right: 0,
      child: Align(
        alignment: Alignment.centerRight,
        child: rightOptions!.label != null
            ? GestureDetector(
                onTap: () {
                  if (rightOptions!.onLabelClick != null) {
                    rightOptions!.onLabelClick!();
                  }
                },
                child: Body2(
                    value: rightOptions!.label!,
                    bold: true,
                    color: rightOptions!.labelColor),
              )
            : Wrap(
                spacing: 20,
                children: rightOptions!.icons!
                    .map((asset) => GestureDetector(
                          onTap: asset.onTap,
                          child: SvgPicture.asset(
                            'assets/icons/${asset.name}.svg',
                            width: 24,
                            colorFilter: ColorFilter.mode(
                                ThemeColor.gray4, BlendMode.srcIn),
                          ),
                        ))
                    .toList(),
              ),
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
      color: ThemeColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Stack(
        children: children,
      ),
    ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
