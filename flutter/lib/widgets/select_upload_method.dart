import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/camera.dart';
import 'package:document_verification_system/screens/upload_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectUploadMethod extends StatelessWidget {
  final String documentType;
  final requestedById;
  const SelectUploadMethod(
      {super.key, required this.requestedById, required this.documentType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.2,
      color: base,
      child: ListView(
        padding: const EdgeInsets.only(top: size_20),
        children: [
          // DrawerHeader(child: Text("Settings")),
          !kIsWeb
              ? ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: size_20),
                  leading: Image.asset(
                    "lib/assets/icons/Camera.png",
                    height: size_30,
                  ),
                  title: const Text("Take a Photo"),
                  onTap: () {
                    List<XFile> pickedImageFromCamera = [];

                    pickImageFromCamera()
                        .then((value) => pickedImageFromCamera.add(value!))
                        .whenComplete(() => {
                              pickedImageFromCamera.isNotEmpty
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UploadScreen(
                                          imageList: pickedImageFromCamera,
                                          requestedById: requestedById,
                                          documentType: documentType,
                                        ),
                                      ),
                                    )
                                  : null
                            });
                  },
                )
              : Container(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: size_20),
            leading: Image.asset(
              "lib/assets/icons/Image.png",
              height: size_30,
            ),
            title: const Text("Upload From Gallery"),
            onTap: () {
              List<XFile> pickedImageFromGallery = [];
              pickMultipleFromGallery()
                  .then((value) => pickedImageFromGallery = value)
                  .whenComplete(() {
                pickedImageFromGallery.isNotEmpty
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadScreen(
                            imageList: pickedImageFromGallery,
                            requestedById: requestedById,
                            documentType: documentType,
                          ),
                        ),
                      )
                    : null;
              });
              print(pickedImageFromGallery);
            },
          )
        ],
      ),
    );
  }
}
