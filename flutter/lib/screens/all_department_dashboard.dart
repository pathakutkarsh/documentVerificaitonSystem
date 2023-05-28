import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/constants/size.dart';
import 'package:document_verification_system/functions/supabase.dart';
import 'package:document_verification_system/widgets/department_name_card.dart';
import 'package:document_verification_system/widgets/select_document.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllDepartmentDashboard extends StatefulWidget {
  const AllDepartmentDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<AllDepartmentDashboard> createState() => _AllDepartmentDashboardState();
}

class _AllDepartmentDashboardState extends State<AllDepartmentDashboard> {
  dynamic listofUserDocuments = {};
  bool isDataLoaded = false;
  bool isListEmpty = false;

  @override
  void initState() {
    super.initState();
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

  List<String> departmentName = ['HR', 'Dev', 'Ops', 'DevOps', 'IT', 'QA'];
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
                      "All Departments",
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
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 0.45),
              padding: kIsWeb
                  ? EdgeInsets.only(
                      left: screenWidth(context) * 0.3,
                      right: screenWidth(context) * 0.3,
                      bottom: screenHeight(context) * 0.14)
                  : EdgeInsets.only(bottom: screenHeight(context) * 0.14),
              shrinkWrap: true,
              itemCount: departmentName.length,
              itemBuilder: ((context, index) {
                return DepartmentNameCard(
                  departmentName: departmentName[index],
                );
              }),
            ),
          )
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
