import 'dart:io';

import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/head.dart';

class PhotoItem extends StatefulWidget {
  const PhotoItem({
    super.key,
    required this.photoPath,
    required this.name,
    required this.titleController,
    this.onChange,
    this.isEditing = false,
    required this.focusNode,
  });

  final String photoPath;
  final String name;
  final TextEditingController titleController;
  final VoidCallback? onChange;
  final bool? isEditing;
  final FocusNode focusNode;

  @override
  State<PhotoItem> createState() => _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> {
  Color overlayColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _changeOverlayColor(widget.focusNode.hasFocus);
    });
  }

  _changeOverlayColor(bool hasFocus) {
    setState(() {
      overlayColor = hasFocus
          ? Colors.black.withOpacity(0.6)
          : Colors.black.withOpacity(0.3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: (MediaQuery.of(context).size.width - 40) * 1.33,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: widget.isEditing == false
                ? FileImage(File(widget.photoPath))
                : NetworkImage(widget.photoPath),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.srcOver),
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onChanged: (text) => {widget.onChange!()},
                    controller: widget.titleController,
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                        hintText: '${widget.name}야 오늘 산책은 어땠어?',
                        hintStyle: TextStyle(
                            color: ThemeColor.white.withOpacity(0.4))),
                    style: HeadTextStyle.getH3Style(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
