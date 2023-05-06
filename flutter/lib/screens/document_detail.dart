import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/widgets/verification_detail.dart';
import 'package:flutter/material.dart';

class DocumentDetails extends StatefulWidget {
  final String documentName;
  final String documentID;
  const DocumentDetails(
      {super.key, required this.documentName, required this.documentID});

  @override
  State<DocumentDetails> createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {
  @override
  void initState() {
    // TODO:Call getDocumentByID to get details
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        shadowColor: Colors.transparent,
        primary: true,
      ),
      body: Column(
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
                      widget.documentName,
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
                          return Image.asset(
                            "lib/assets/icons/sampleImage.png",
                          );
                        });
                  },
                  child: Image.asset(
                    "lib/assets/icons/sampleImage.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Text("Requested by: Company Name")
            ],
          ),
          VerificationDetails(
            isVerified: true,
            isValidation: false,
          ),
          VerificationDetails(
            isVerified: false,
            isValidation: true,
          )
        ],
      ),
    );
  }
}
