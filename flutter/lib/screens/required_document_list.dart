import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
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
  @override
  void initState() {
    // TODO:getList of Documents from requestedID
    super.initState();
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
            child: ListView.builder(
              padding: kIsWeb
                  ? EdgeInsets.only(
                      left: screenWidth(context) * 0.3,
                      right: screenWidth(context) * 0.3,
                      bottom: screenHeight(context) * 0.14)
                  : EdgeInsets.only(bottom: screenHeight(context) * 0.14),
              shrinkWrap: true,
              itemCount: fileName.length,
              itemBuilder: ((context, index) {
                return DashboardCard(
                  fileName: fileName[index],
                  imageUrl: "lib/assets/icons/uploadicon.png",
                  uploadFile: true,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
