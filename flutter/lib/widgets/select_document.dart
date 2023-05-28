import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/generate_string.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectDocument extends StatefulWidget {
  const SelectDocument({super.key});

  @override
  State<SelectDocument> createState() => _SelectDocumentState();
}

class _SelectDocumentState extends State<SelectDocument> {
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  bool isDocumentSelected = false;
  bool isGenerateButtonClicked = false;
  bool isDepartmentSelected = false;
  String generatedCode = "";
  String selectedDepartmentis = 'HR';
  List<String> selectedDocuments = [];
  Map<String, bool> selectionList = {
    "Aadhar": false,
    "HSC Marksheet": false,
    "SSC Marksheet": false,
  };
  List<DropdownMenuItem<String>> departmentsToSelect =
      <String>['HR', 'Dev', 'Ops', 'DevOps', 'IT', 'QA'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      backgroundColor: base,
      child: Container(
        padding: const EdgeInsets.only(top: size_24, bottom: size_24),
        width: screenWidth(context) * 0.2,
        // height: screenHeight(context) * 0.3,
        child: isGenerateButtonClicked
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "The Generated Code is",
                    style: TextStyle(
                      color: primary,
                      fontSize: size_16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(size_16),
                    child: Text(generatedCode),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(
                        () {
                          Clipboard.setData(ClipboardData(text: generatedCode))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Copied Code to Clipboard")));
                          });
                        },
                      );
                      isDocumentSelected
                          ? {
                              isGenerateButtonClicked = true,
                            }
                          : null;
                    },
                    child: Container(
                      width: 240,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isDocumentSelected ? primary : red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Copy to Clipboard",
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
              )
            : isDepartmentSelected
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Select The Documents to Request",
                        style: TextStyle(
                          color: primary,
                          fontSize: size_16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(size_16),
                        child: ListView.builder(
                          itemCount: selectionList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              checkColor: primary,
                              title: Text(selectionList.keys.elementAt(index)),
                              value: selectionList.values.elementAt(index),
                              onChanged: (value) {
                                selectionList[selectionList.keys
                                    .elementAt(index)] = value!;

                                setState(
                                  () {
                                    if (value) {
                                      selectedDocuments.add(
                                          selectionList.keys.elementAt(index));
                                    } else {
                                      selectedDocuments.remove(
                                          selectionList.keys.elementAt(index));
                                    }
                                    selectedDocuments.isNotEmpty
                                        ? isDocumentSelected = true
                                        : isDocumentSelected = false;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          setState(
                            () {},
                          );
                          isDocumentSelected
                              ? {
                                  generatedCode = getRandomString(6),
                                }
                              : null;
                          createNewDocumentRequest(
                            generatedCode,
                            await getUserId(),
                            selectionList.values.elementAt(0),
                            selectionList.values.elementAt(1),
                            selectionList.values.elementAt(2),
                            selectedDepartmentis,
                          ).whenComplete(() => {
                                isGenerateButtonClicked = true,
                              });
                          setState(() {});
                        },
                        child: Container(
                          width: 240,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isDocumentSelected ? primary : red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Generate Request Code",
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
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Select The Department for Request",
                        style: TextStyle(
                          color: primary,
                          fontSize: size_16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      DropdownButton<String>(
                        hint: const Text('Select Department'),
                        // value: departmentsToSelect.first.value,
                        items: departmentsToSelect,
                        onChanged: (value) {
                          setState(() {
                            isDepartmentSelected = !isDepartmentSelected;
                            selectedDepartmentis = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
