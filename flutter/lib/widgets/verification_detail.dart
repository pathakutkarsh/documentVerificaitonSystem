import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:flutter/material.dart';

class VerificationDetails extends StatelessWidget {
  bool isVerified;
  bool isValidation;
  VerificationDetails(
      {super.key, this.isVerified = false, this.isValidation = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(size_8),
      child: Material(
        elevation: 10.0,
        shadowColor: isVerified ? green : red,
        borderRadius: BorderRadius.circular(size_16),
        child: ListTile(
          contentPadding: const EdgeInsets.all(size_6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size_16),
            side: BorderSide.none,
          ),
          style: ListTileStyle.drawer,
          tileColor: base,
          leading: Padding(
            padding: const EdgeInsets.all(size_6),
            child: isVerified
                ? Image.asset("lib/assets/icons/checkmark.png")
                : Image.asset("lib/assets/icons/redshieldicon.png"),
          ),
          title: isValidation
              ? isVerified
                  ? const Text("Validated")
                  : const Text("Not Validated")
              : isVerified
                  ? const Text("Verified")
                  : const Text("Not Verified"),
          trailing: Icon(
            Icons.arrow_right_rounded,
            color: isVerified ? green : red,
            size: size_30,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  backgroundColor: base,
                  child: Container(
                    padding: const EdgeInsets.only(top: size_24),
                    width: screenWidth(context) * 0.2,
                    height: screenHeight(context) * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isValidation
                            ? Text(
                                "What is Validation?",
                                style: TextStyle(
                                    color: isVerified ? green : red,
                                    fontSize: size_24,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal),
                              )
                            : Text(
                                "What is Verification?",
                                style: TextStyle(
                                    color: isVerified ? green : red,
                                    fontSize: size_24,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal),
                              ),
                        isValidation
                            ? const Text(
                                "The Details of your documents are cross checked with the data present in Government Database",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size_16,
                                    overflow: TextOverflow.visible),
                              )
                            : const Text(
                                "Your documents are being passed to our algorithm which helps identify if they were tampered or not.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size_16,
                                    overflow: TextOverflow.visible),
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
