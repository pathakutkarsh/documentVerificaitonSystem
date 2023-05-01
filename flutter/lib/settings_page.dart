import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/constants/variables.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    urlController.text = getServerURL();
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(size_10),
            child: Container(
              width: screenWidth(context) * 0.9,
              height: screenHeight(context) * 0.2,
              margin: const EdgeInsets.only(bottom: size_20, top: size_20),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.url,
                autofillHints: const [AutofillHints.name],
                controller: urlController,
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
                  labelText: 'URL to transfer',
                  hintText: "Enter URL",
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
                onEditingComplete: () {
                  setServerURL(urlController.text);
                  print(getServerURL());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
