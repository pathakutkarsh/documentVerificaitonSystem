import 'dart:typed_data';

import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/constants/variables.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/verification_detail.dart';
import 'package:flutter/material.dart';

class DocumentDetails extends StatefulWidget {
  final String documentName;
  final String documentID;
  final Map imageInfo;
  const DocumentDetails(
      {super.key,
      required this.documentName,
      required this.documentID,
      required this.imageInfo});

  @override
  State<DocumentDetails> createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {
  late Uint8List uploadFile;
  bool isFileLoaded = false;
  late DateTime createdOn;
  bool isCommercial = false;
  // bool  isCommercial = await isUserCommercial(userId);
  getDownloadedFile() async {
    // await isUserCommercial(getUserId()).then((value) => isCommercial = value);
    downloadImageFromFileName(widget.imageInfo['edited_image_name'],
            widget.imageInfo['file_name'])
        .then(
          (value) => setState(
            () {
              uploadFile = value;
              isFileLoaded = true;
            },
          ),
        )
        .onError(
          (error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(error.toString()),
                );
              }),
        );
  }

  @override
  void initState() {
    super.initState();
    getDownloadedFile();
  }

// need to use image.network for browser viewing image
  @override
  Widget build(BuildContext context) {
    createdOn = DateTime.parse(widget.imageInfo['created_at']);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          shadowColor: Colors.transparent,
          primary: true,
          // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(size_100),
                ),
                child: Container(
                  color: primary,
                  height: screenHeight(context) * 0.175,
                  width: screenWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(size_12),
                        child: Text(
                          widget.imageInfo['file_type'],
                          style: const TextStyle(
                              fontSize: size_40,
                              color: base,
                              backgroundColor: Colors.transparent),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: screenHeight(context) * 0.2,
                    width: screenWidth(context) * 0.4,
                    padding: const EdgeInsets.symmetric(
                        vertical: size_10, horizontal: size_10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            builder: (builder) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: isFileLoaded
                                      ? Image.memory(
                                          uploadFile,
                                        )
                                      : const SizedBox(
                                          width: size_10,
                                          height: size_10,
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                              );
                            });
                      },
                      child: isFileLoaded
                          ? Image.memory(
                              uploadFile,
                              fit: BoxFit.scaleDown,
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "File Name: ${widget.imageInfo['file_name']}",
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                            "Created on: ${createdOn.day}-${createdOn.month}-${createdOn.year}"),
                        Text(
                            "Requested by: ${widget.imageInfo['requested_by']}"),
                      ],
                    ),
                  ),
                ],
              ),
              isFileLoaded
                  ? VerificationDetails(
                      isVerified: widget.imageInfo['is_verified'],
                      isValidation: false,
                    )
                  : const CircularProgressIndicator(),
              isFileLoaded
                  ? VerificationDetails(
                      isVerified: widget.imageInfo['is_validated'],
                      isValidation: true,
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
        bottomSheet: getIsUserCommercial()
            ? SingleChildScrollView(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.imageInfo['is_accepted'] ? green : primary,
                      maximumSize: const Size(size_200, size_200),
                      minimumSize: const Size(size_60, size_60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size_10)),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                "Are you sure to accept the document"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  markDocumentAsAccepted(widget.imageInfo['id'])
                                      .whenComplete(
                                          () => Navigator.pop(context));
                                  setState(() {
                                    getDownloadedFile();
                                  });
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Accept Document"),
                  ),
                ),
              )
            : null);
  }
}
