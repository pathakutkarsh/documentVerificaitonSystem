import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/dashboard_card.dart';
import 'package:document_verification_system/widgets/enter_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic listofUserDocuments = {};
  bool isDataLoaded = false;

  documentData() async {
    await getAllDocumentsByUserId(getUserId())
        .then((value) => setState(
              () {
                listofUserDocuments = value;
                isDataLoaded = true;
                print(value);
              },
            ))
        .onError(
          (error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(error.toString()),
                );
              }),
        );
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
            // DrawerHeader(child: Text("Settings")),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: size_20),
              trailing: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () {
                logoutuser().whenComplete(
                    () => {Navigator.pushReplacementNamed(context, '/')});
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: size_20),
              trailing: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
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
          isDataLoaded
              ? Expanded(
                  child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      isDataLoaded = false;
                    });
                    await documentData();
                  },
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
                  ),
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
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const EnterCodeDialog();
                        });
                    // pickImageFromCamera()
                    //     .then((value) => print(value!.path))
                    //     .whenComplete(() => print("Image completed"));
                  },
                  child: Container(
                    width: size_80,
                    height: size_80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(size_5, size_5),
                            color: primary.withOpacity(0.4),
                            spreadRadius: size_1,
                            blurRadius: size_15,
                          )
                        ]),
                    child: const Icon(
                      Icons.add,
                      size: size_50,
                      color: base,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
