import 'dart:io';

import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  final List<XFile> imageList;
  const UploadScreen({super.key, required this.imageList});

  @override
  State<UploadScreen> createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation iconColor;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )
      ..repeat(reverse: true)
      ..addListener(
        () {
          if (_animationController.isCompleted) {
            _animationController.repeat();
          }
          setState(() {});
        },
      );
    iconColor = ColorTween(
      begin: base,
      end: primary,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          primary: true,
          leading: const BackButton()),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.upload,
              color: iconColor.value,
              size: size_100,
            ),
            const SizedBox(
              height: size_30,
            ),
            Center(
              child: Container(
                height: screenHeight(context) * 0.2,
                width: screenWidth(context) * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.file(
                  File(widget.imageList[0].path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: size_30,
            ),
            const Text(
              "Hold up while we Upload your Data ",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: size_20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
