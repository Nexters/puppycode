import 'package:flutter/material.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: (MediaQuery.of(context).size.width - 40) * 1.33,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }
}
