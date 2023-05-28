import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/department_document_list_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartmentDocumentListScreen extends StatefulWidget {
  final String departmentName;
  const DepartmentDocumentListScreen({super.key, this.departmentName = ''});
  @override
  State<DepartmentDocumentListScreen> createState() =>
      DepartmentDocumentListScreenState();
}

class DepartmentDocumentListScreenState
    extends State<DepartmentDocumentListScreen> {
  bool isDetailLoaded = false;
  List getRequiredDocumentDetails = [];
  getRequiredDocuments() async {
    await getListofRequestedDocumentsByDepartment(widget.departmentName).then(
      (value) => setState(
        () {
          getRequiredDocumentDetails = value;
          // createCardsBasedOnRequiredDocuments();
          isDetailLoaded = true;
        },
      ),
    );
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(size_12),
                              child: Text(
                                "List of Requested Documents for ${widget.departmentName}",
                                style: const TextStyle(
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
                    getRequiredDocumentDetails.isNotEmpty
                        ? ListView.builder(
                            padding: kIsWeb
                                ? EdgeInsets.only(
                                    left: screenWidth(context) * 0.3,
                                    right: screenWidth(context) * 0.3,
                                    bottom: screenHeight(context) * 0.14)
                                : EdgeInsets.only(
                                    bottom: screenHeight(context) * 0.14),
                            shrinkWrap: true,
                            itemCount: getRequiredDocumentDetails.length,
                            itemBuilder: ((context, index) {
                              return DepartmentDocumentListCard(
                                  getRequiredDocumentDetails:
                                      getRequiredDocumentDetails[index]);
                            }),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('lib/assets/fileUpload.png'),
                              const Text(
                                "Looks Like No Documents \nare Requested for This Department",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size_18,
                                ),
                              )
                            ],
                          )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
