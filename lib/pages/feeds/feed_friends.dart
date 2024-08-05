import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              ),
              FeedUserStatus(
                name: '푸름이',
                hasWalked: true,
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
  });

  final String name;
  final bool hasWalked;
  final bool isLast;

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
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => {_onFriendClick()},
                    child: Container(
                      width: 18,
                      height: 18,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.13),
                              blurRadius: 9,
                              offset: const Offset(0, 1.13),
                            )
                          ],
                          shape: BoxShape.circle,
                          color: hasWalked
                              ? const Color(0xFF36DBBF)
                              : Colors.white),
                      child: SvgPicture.asset(
                        hasWalked
                            ? 'assets/icons/paw_small.svg'
                            : 'assets/icons/push.svg',
                      ),
                    ),
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
