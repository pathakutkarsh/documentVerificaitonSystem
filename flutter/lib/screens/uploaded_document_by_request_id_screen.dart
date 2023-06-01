import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/widgets/user_document_details_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../functions/supabase.dart';

class UploadedDocumentByRequestIdScreen extends StatefulWidget {
  final String requesterId;
  const UploadedDocumentByRequestIdScreen(
      {super.key, required this.requesterId});

  @override
  State<UploadedDocumentByRequestIdScreen> createState() =>
      _UploadedDocumentByRequestIdScreenState();
}

class _UploadedDocumentByRequestIdScreenState
    extends State<UploadedDocumentByRequestIdScreen> {
  bool isDetailLoaded = false;
  List listofAllDocumentsbyRequester = [];
  getRequiredDocuments() async {
    await getAllDocumentsByRequesterID(widget.requesterId).then((value) {
      setState(
        () {
          listofAllDocumentsbyRequester = value;
          createUserDocumentMap();
          // createCardsBasedOnRequiredDocuments();
          isDetailLoaded = true;
        },
      );
    });
  }

  List<Map> userDocumentMap = [];
  createUserDocumentMap() {
    Map value = {};
    for (value in listofAllDocumentsbyRequester) {
      if (userDocumentMap
          .where((element) => element['user_id'] == value['user_id'])
          .isEmpty) {
        userDocumentMap.add({'user_id': value['user_id']});
        userDocumentMap
            .where((element) => element['user_id'] == value['user_id'])
            .first
            .addEntries({
              'file_list': [
                {value['file_type']: value}
              ]
            }.entries);
      } else {
        userDocumentMap
            .where((element) => element['user_id'] == value['user_id'])
            .first['file_list']
            .add({value['file_type']: value});
      }
    }
    print(userDocumentMap);
  }

  @override
  void initState() {
    super.initState();
    getRequiredDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        shadowColor: Colors.transparent,
        primary: true,
      ),
      body: isDetailLoaded
          ? SingleChildScrollView(
              child: Column(
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
                              "List of Users",
                              style: TextStyle(
                                  fontSize: size_30,
                                  color: base,
                                  backgroundColor: Colors.transparent),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: kIsWeb
                        ? EdgeInsets.only(
                            left: screenWidth(context) * 0.3,
                            right: screenWidth(context) * 0.3,
                            bottom: screenHeight(context) * 0.14)
                        : EdgeInsets.only(bottom: screenHeight(context) * 0.14),
                    shrinkWrap: true,
                    itemCount: userDocumentMap.length,
                    itemBuilder: ((context, index) {
                      return UserDocumentDetailsCard(
                          getRequiredDocumentDetails:
                              userDocumentMap[index]);
                    }),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
