import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';

class FeedFriends extends StatelessWidget {
  const FeedFriends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FeedUserStatus(
                name: '포포',
                hasWalked: true,
                isMine: true,
              ),
              FeedUserStatus(
                name: '푸름이',
                hasWalked: true,
                isFocused: true,
              ),
              FeedUserStatus(
                name: '초코',
                hasWalked: false,
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
    this.isLast = false,
    this.isFocused = false,
    this.isMine = false,
  });

  final String name;
  final bool hasWalked;
  final bool isLast;
  final bool isFocused;
  final bool isMine;

  _onFriendClick() {
    if (hasWalked) return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: const Color(0xFFEFF2F5),
                  border: isFocused
                      ? Border.all(color: ThemeColor.primary, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    isMine
                        ? 'https://img.segye.com/content/image/2018/12/07/20181207794966.jpg'
                        : 'https://image.fnnews.com/resource/media/image/2024/05/31/202405310911189673_l.jpg',
                    fit: BoxFit.cover,
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
            color: const Color(0xFF8D959A),
          )
        ],
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
