import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartmentDocumentListCard extends StatelessWidget {
  final Map getRequiredDocumentDetails;
  DepartmentDocumentListCard(
      {super.key, required this.getRequiredDocumentDetails});

  List<Widget> requestedDocumentWidgetList = [];
  createCardsBasedOnRequiredDocuments() {
    if (getRequiredDocumentDetails['request_hsc']) {
      requestedDocumentWidgetList.add(const ListTile(
        title: Text(
          "HSC Marksheet",
        ),
      ));
    }
    if (getRequiredDocumentDetails['request_aadhar']) {
      requestedDocumentWidgetList.add(const ListTile(
        title: Text(
          "Aadhar Card",
        ),
      ));
    }
    if (getRequiredDocumentDetails['request_ssc']) {
      requestedDocumentWidgetList.add(const ListTile(
        title: Text(
          "SSC Marksheet",
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime createdOn =
        DateTime.parse(getRequiredDocumentDetails['created_at']);
    return Padding(
      padding: const EdgeInsets.all(size_8),
      child: Material(
        elevation: 10.0,
        shadowColor: primary,
        borderRadius: BorderRadius.circular(size_16),
        child: ExpansionTile(
          
          // contentPadding: const EdgeInsets.all(size_10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size_16),
            side: BorderSide.none,
          ),
          // style: ListTileStyle.list,
          // tileColor: base,
          title: Text(
            getRequiredDocumentDetails['request_id'],
          ),
          trailing: const Icon(
            Icons.arrow_right_rounded,
            color: primary,
            size: size_30,
          ),
          children: [
            ListTile(
              dense: true,
              title: Text(
                "Created on: ${DateFormat.yMd().add_jm().format(createdOn)}",
              ),
            ),
            const ListTile(
              dense: true,
              title: Text(
                "Requested Documents are:",
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: size_10,
              endIndent: size_10,
            ),
            getRequiredDocumentDetails['request_hsc']
                ? const ListTile(
                    dense: true,
                    title: Text(
                      "HSC Marksheet",
                    ),
                  )
                : Container(),
            getRequiredDocumentDetails['request_ssc']
                ? const ListTile(
                    dense: true,
                    title: Text(
                      "SSC Marksheet",
                    ),
                  )
                : Container(),
            getRequiredDocumentDetails['request_aadhar']
                ? const ListTile(
                    dense: true,
                    title: Text(
                      "Aadhar Card",
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
