import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FeedFriends extends StatelessWidget {
  const FeedFriends({
    super.key,
    required this.onSelect,
    this.focusedUserId,
  });

  final void Function(String?) onSelect;
  final String? focusedUserId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FeedUserStatus(
                name: '포포',
                hasWalked: true,
                isMine: true,
                focusedUserId: focusedUserId,
                onClick: onSelect,
              ),
              FeedUserStatus(
                name: '푸름이',
                hasWalked: true,
                focusedUserId: focusedUserId,
                onClick: onSelect,
              ),
              FeedUserStatus(
                name: '초코',
                hasWalked: false,
                focusedUserId: focusedUserId,
                onClick: onSelect,
              )
            ],
          )),
    );
  }
}

class FeedUserStatus extends StatelessWidget {
  const FeedUserStatus({
    super.key,
    required this.name,
    required this.hasWalked,
    required this.onClick,
    this.focusedUserId,
    this.isLast = false,
    this.isMine = false,
  });

  final String name;
  final bool hasWalked;
  final bool isLast;
  final void Function(String?) onClick;

  final String? focusedUserId;
  final bool isMine;

  _onFriendClick() {
    if (hasWalked) return;
  }

  @override
  Widget build(BuildContext context) {
    var isOtherUserFocused = focusedUserId != null && focusedUserId != name;
    var isMeFocused = focusedUserId != null && focusedUserId == name;

    var isDimmed = isOtherUserFocused || (!isMeFocused && !hasWalked);
    var nameColor = isDimmed ? ThemeColor.gray3 : ThemeColor.gray6;

    return GestureDetector(
      onTap: () => {onClick(name)},
      child: Container(
        width: 48,
        margin: EdgeInsets.only(right: isLast ? 0 : 6),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ThemeColor.gray2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      isMine
                          ? 'https://img.segye.com/content/image/2018/12/07/20181207794966.jpg'
                          : 'https://image.fnnews.com/resource/media/image/2024/05/31/202405310911189673_l.jpg',
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.colorDodge,
                      color:
                          isDimmed ? ThemeColor.white.withOpacity(0.4) : null,
                    ),
                  ),
                ),
                if (isMine)
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Body4(
                          value: '나',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          textShadow: Shadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        )),
                  ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => {_onFriendClick()},
                      child: FeedFriendIcon(hasWalked: hasWalked),
                    ))
              ],
            ),
            const SizedBox(height: 4),
            Body4(
              value: name,
              color: nameColor,
              fontWeight: isMeFocused ? FontWeight.w600 : FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}

class FeedFriendIcon extends StatelessWidget {
  const FeedFriendIcon({
    super.key,
    required this.hasWalked,
  });

  final bool hasWalked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              blurRadius: 9,
              offset: const Offset(0, 1.13),
            )
          ],
          shape: BoxShape.circle,
          color: hasWalked ? ThemeColor.primary : ThemeColor.white),
      child: SvgPicture.asset(
        hasWalked ? 'assets/icons/paw_small.svg' : 'assets/icons/push.svg',
      ),
    );
  }
}
