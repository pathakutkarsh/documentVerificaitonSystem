import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/screens/required_document_list.dart';
import 'package:flutter/material.dart';

class EnterCodeDialog extends StatefulWidget {
  const EnterCodeDialog({super.key});

  @override
  State<EnterCodeDialog> createState() => _EnterCodeDialogState();
}

class _EnterCodeDialogState extends State<EnterCodeDialog> {
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      backgroundColor: base,
      child: Container(
        padding: const EdgeInsets.only(top: size_24),
        width: screenWidth(context) * 0.2,
        height: screenHeight(context) * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter The Code",
              style: TextStyle(
                  color: primary,
                  fontSize: size_24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
            Padding(
              padding: const EdgeInsets.all(size_16),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                controller: codeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, style: BorderStyle.solid, color: primary),
                      borderRadius: BorderRadius.circular(size_7)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, style: BorderStyle.solid, color: primary),
                      borderRadius: BorderRadius.circular(size_7)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, style: BorderStyle.solid, color: primary),
                      borderRadius: BorderRadius.circular(size_7)),
                  labelText: 'Enter Code',
                  hintText: "Enter Code",
                  labelStyle: const TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: size_16,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: size_12,
                  ),
                ),
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequiredDocumentList(
                      requestID: "adf",
                    ),
                  ),
                );
              },
              child: Container(
                width: 240,
                height: 50,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Enter",
                    style: TextStyle(
                        color: base,
                        fontSize: size_16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
