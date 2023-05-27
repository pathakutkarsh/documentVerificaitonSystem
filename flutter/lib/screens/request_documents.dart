import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/dashboard_card.dart';
import 'package:document_verification_system/widgets/select_document.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RequestDocument extends StatefulWidget {
  const RequestDocument({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestDocument> createState() => _RequestDocumentState();
}

class _RequestDocumentState extends State<RequestDocument> {
  dynamic listofUserDocuments = {};
  bool isDataLoaded = false;

  documentData() async {
    await getAllDocumentsByRequesterID('cFXi7q').then((value) => setState(
          () {
            listofUserDocuments = value;
            isDataLoaded = true;
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    documentData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> fileName = [
    "Aadhar Card",
    "Pan Card",
    "SSC Certificate",
    "HSC Certificate",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base,
      drawer: Drawer(
        backgroundColor: base,
        child: ListView(
          reverse: true,
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: size_20),
              trailing: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () {
                logoutuser().whenComplete(
                    () => {Navigator.pushReplacementNamed(context, '/login')});
              },
            ),
            // DrawerHeader(child: Text("Settings")),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: size_20),
              trailing: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: primary,
        shadowColor: Colors.transparent,
        primary: true,
      ),
      body: Column(
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(size_100),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isDataLoaded = false;
                });
                documentData();
              },
              child: Container(
                color: primary,
                height: screenHeight(context) * 0.2,
                width: screenWidth(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(size_12),
                      child: Text(
                        "All Documents",
                        style: TextStyle(
                            fontSize: size_40,
                            color: base,
                            backgroundColor: Colors.transparent),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isDataLoaded
              ? Expanded(
                  child: ListView.builder(
                  padding: kIsWeb
                      ? EdgeInsets.only(
                          left: screenWidth(context) * 0.3,
                          right: screenWidth(context) * 0.3,
                          bottom: screenHeight(context) * 0.14)
                      : EdgeInsets.only(bottom: screenHeight(context) * 0.14),
                  shrinkWrap: true,
                  itemCount: listofUserDocuments.length,
                  itemBuilder: ((context, index) {
                    return DashboardCard(
                      fileName: listofUserDocuments[index]['file_type'],
                      imageInfo: listofUserDocuments[index],
                    );
                  }),
                ))
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
      bottomSheet: SingleChildScrollView(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size_50),
                    topRight: Radius.circular(size_50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 15,
                    )
                  ],
                ),
                width:
                    kIsWeb ? screenWidth(context) * 0.4 : screenWidth(context),
                height: screenHeight(context) * 0.14,
              ),
              Positioned(
                bottom: screenHeight(context) * 0.09,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(size_200, size_200),
                    minimumSize: const Size(size_60, size_60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size_10)),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const SelectDocument();
                        });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Create New Request"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
