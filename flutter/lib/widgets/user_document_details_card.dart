import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/screens/document_detail.dart';
import 'package:document_verification_system/screens/uploaded_document_by_request_id_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDocumentDetailsCard extends StatefulWidget {
  final Map getRequiredDocumentDetails;
  const UserDocumentDetailsCard(
      {super.key, required this.getRequiredDocumentDetails});

  @override
  State<UserDocumentDetailsCard> createState() =>
      _UserDocumentDetailsCardState();
}

class _UserDocumentDetailsCardState extends State<UserDocumentDetailsCard> {
  Map userDetails = {};
  getUsername() async {
    await getUserInfoFromDatabase(widget.getRequiredDocumentDetails['user_id'])
        .then((value) {
      setState(() {
        userDetails = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    DateTime createdOn =
        DateTime.parse(widget.getRequiredDocumentDetails['created_at']);
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
            "${userDetails['first_name']} ${userDetails['last_name']} ",
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.arrow_right_rounded,
              color: primary,
              size: size_30,
            ),
            onPressed: () {},
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
            ListTile(
              textColor: primary,
              dense: true,
              title: Text(widget.getRequiredDocumentDetails['file_type']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentDetails(
                      documentName:
                          widget.getRequiredDocumentDetails['file_type'],
                      documentID:
                          widget.getRequiredDocumentDetails['id'].toString(),
                      imageInfo: widget.getRequiredDocumentDetails,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: size_4,
            )
          ],
        ),
      ),
    );
  }
}
