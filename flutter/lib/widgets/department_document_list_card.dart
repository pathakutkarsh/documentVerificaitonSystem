import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/screens/uploaded_document_by_request_id_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DepartmentDocumentListCard extends StatelessWidget {
  final Map getRequiredDocumentDetails;
  const DepartmentDocumentListCard(
      {super.key, required this.getRequiredDocumentDetails});

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
          trailing: IconButton(
            icon: const Icon(
              Icons.arrow_right_rounded,
              color: primary,
              size: size_30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UploadedDocumentByRequestIdScreen(
                        requesterId: getRequiredDocumentDetails['request_id']);
                  },
                ),
              );
            },
          ),
          children: [
            ListTile(
              dense: true,
              title: Text(
                "Generated Code : ${getRequiredDocumentDetails['request_id']}",
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(
                        text: getRequiredDocumentDetails['request_id']))
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Copied Code to Clipboard")));
                });
              },
            ),
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
