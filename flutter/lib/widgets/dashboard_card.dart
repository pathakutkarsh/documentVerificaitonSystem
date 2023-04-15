import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

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
          leading: Image.asset("lib/assets/pdf.png"),
          title: const Text("Document Name Goes Here"),
          trailing: const Icon(
            Icons.arrow_right_rounded,
            color: primary,
            size: size_30,
          ),
        ),
      ),
    );
  }
}
