import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/screens/document_detail.dart';
import 'package:document_verification_system/widgets/select_upload_method.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  bool uploadFile = false;
  String fileName = '';
  String imageUrl = '';
  String requestId = '';
  Map imageInfo;
  DashboardCard({
    super.key,
    this.uploadFile = false,
    this.fileName = "FileName",
    this.imageUrl = 'lib/assets/icons/uploadicon.png',
    this.requestId = '',
    this.imageInfo = const {},
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  void initState() {
    super.initState();
  }

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
          leading: SizedBox(
            width: size_40,
            height: size_40,
            child: Image.asset(
              'lib/assets/icons/documenticon.png',
              color: Colors.black,
            ),
          ),
          title: Text(widget.fileName),
          trailing: const Icon(
            Icons.arrow_right_rounded,
            color: primary,
            size: size_30,
          ),
          onTap: () {
            if (widget.uploadFile) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SelectUploadMethod(
                      requestedById: widget.requestId,
                      documentType: widget.fileName);
                },
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocumentDetails(
                          documentName: widget.fileName,
                          documentID: widget.imageInfo['id'].toString(),
                          imageInfo: widget.imageInfo,
                        )),
              );
            }
          },
        ),
      ),
    );
  }
}
