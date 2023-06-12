import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/screens/department_document_list_screen.dart';
import 'package:flutter/material.dart';

class DepartmentNameCard extends StatefulWidget {
  bool uploadFile = false;
  String departmentName = '';
  String requestId = '';
  Map imageInfo;
  DepartmentNameCard({
    super.key,
    this.uploadFile = false,
    this.departmentName = "FileName",
    this.requestId = '',
    this.imageInfo = const {},
  });

  @override
  State<DepartmentNameCard> createState() => _DepartmentNameCardState();
}

class _DepartmentNameCardState extends State<DepartmentNameCard> {
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
          tileColor: base,
          leading: SizedBox(
            width: size_30,
            height: size_30,
            child: Image.asset(
              'lib/assets/icons/calendarblueicon.png',
              color: Colors.grey,
            ),
          ),
          title: Text(widget.departmentName),
          trailing: const Icon(
            Icons.arrow_right_rounded,
            color: primary,
            size: size_30,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepartmentDocumentListScreen(
                  departmentName: widget.departmentName,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
