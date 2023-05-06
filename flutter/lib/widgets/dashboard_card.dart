import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/screens/document_detail.dart';
import 'package:document_verification_system/widgets/select_upload_method.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  bool uploadFile = false;
  String fileName = '';
  String imageUrl = '';
  DashboardCard(
      {super.key,
      this.uploadFile = false,
      this.fileName = "FileName",
      this.imageUrl = 'lib/assets/icons/uploadicon.png'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(size_8),
      child: Material(
        elevation: 10.0,
        shadowColor: primary,
        borderRadius: BorderRadius.circular(size_16),
        child: ListTile(
          contentPadding: const EdgeInsets.all(size_10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size_16),
            side: BorderSide.none,
          ),
          style: ListTileStyle.drawer,
          tileColor: base,
          leading: Image.asset(
            imageUrl,
            color: Colors.grey,
          ),
          title: Text(fileName),
          trailing: const Icon(
            Icons.arrow_right_rounded,
            color: primary,
            size: size_30,
          ),
          onTap: () {
            if (uploadFile) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const SelectUploadMethod();
                },
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocumentDetails(
                        documentName: fileName, documentID: 'ad')),
              );
            }
          },
        ),
      ),
    );
  }
}
