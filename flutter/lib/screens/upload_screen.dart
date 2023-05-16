import 'dart:async';
import 'dart:io';
import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/enter_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  final List<XFile> imageList;
  final requestedById;
  final documentType;
  const UploadScreen(
      {super.key,
      required this.imageList,
      required this.requestedById,
      required this.documentType});

  @override
  State<UploadScreen> createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen> {
  uploadFile() async {
    await uploadImageToBucket(
        widget.imageList[0].path, widget.imageList[0].name);
  }

  createEntry() {
    uploadNewDocument(widget.imageList[0].name, false, false, '1',
        widget.requestedById, widget.documentType);
  }

  @override
  void initState() {
    super.initState();
    uploadFile();
    createEntry();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Requested by id at upload screen is ${widget.requestedById}");
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          primary: true,
          leading: const BackButton()),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: size_30,
            ),
            Image.asset(
              "lib/assets/icons/uploadicon.png",
              color: primary,
            ),
            const SizedBox(
              height: size_30,
            ),
            Center(
              child: Container(
                height: screenHeight(context) * 0.4,
                width: screenWidth(context) * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: kIsWeb
                    ? Image.network(
                        widget.imageList[0].path,
                        fit: BoxFit.fill,
                      )
                    : Image.file(
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
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 240,
                height: 50,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Go Back ",
                    style: TextStyle(
                        color: base,
                        fontSize: size_16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
