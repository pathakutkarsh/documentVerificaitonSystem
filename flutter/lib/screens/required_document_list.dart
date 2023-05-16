import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/dashboard_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RequiredDocumentList extends StatefulWidget {
  final String requestID;
  const RequiredDocumentList({super.key, this.requestID = ''});
  @override
  State<RequiredDocumentList> createState() => RequiredDocumentListState();
}

class RequiredDocumentListState extends State<RequiredDocumentList> {
  bool isDetailLoaded = false;
  Map getRequiredDocumentDetails = {};
  getRequiredDocuments() async {
    await getListofRequestedDocumentsFromID(widget.requestID).then(
      (value) => setState(
        () {
          getRequiredDocumentDetails = value;
          createCardsBasedOnRequiredDocuments();
          isDetailLoaded = true;
        },
      ),
    );
  }

  List<Widget> documentType = [];

  createCardsBasedOnRequiredDocuments() {
    if (getRequiredDocumentDetails['request_hsc']) {
      documentType.add(
        Padding(
          padding: kIsWeb
              ? EdgeInsets.only(
                  left: screenWidth(context) * 0.3,
                  right: screenWidth(context) * 0.3,
                  bottom: screenHeight(context) * 0.5,
                )
              : EdgeInsets.only(bottom: screenHeight(context) * 0.0),
          child: DashboardCard(
            fileName: "HSC Marksheet",
            imageUrl: "lib/assets/icons/uploadicon.png",
            requestId: widget.requestID,
            uploadFile: true,
          ),
        ),
      );
    }
    if (getRequiredDocumentDetails['request_aadhar']) {
      documentType.add(
        Padding(
          padding: kIsWeb
              ? EdgeInsets.only(
                  left: screenWidth(context) * 0.3,
                  right: screenWidth(context) * 0.3,
                  bottom: screenHeight(context) * 0.5)
              : EdgeInsets.only(bottom: screenHeight(context) * 0.0),
          child: DashboardCard(
            fileName: "Aadhar Card",
            imageUrl: "lib/assets/icons/uploadicon.png",
            requestId: widget.requestID,
            uploadFile: true,
          ),
        ),
      );
    }
    if (getRequiredDocumentDetails['request_ssc']) {
      documentType.add(
        Padding(
          padding: kIsWeb
              ? EdgeInsets.only(
                  left: screenWidth(context) * 0.3,
                  right: screenWidth(context) * 0.3,
                  bottom: screenHeight(context) * 0.5)
              : EdgeInsets.only(bottom: screenHeight(context) * 0.0),
          child: DashboardCard(
            fileName: "SSC Marksheet",
            imageUrl: "lib/assets/icons/uploadicon.png",
            requestId: widget.requestID,
            uploadFile: true,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getRequiredDocuments();
  }

  List<String> fileName = ["Aadhar Card", "HSC Result"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        shadowColor: Colors.transparent,
        primary: true,
      ),
      body: isDetailLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(size_12),
                          child: Text(
                            "List of Document",
                            style: TextStyle(
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
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children: documentType,
                )),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
