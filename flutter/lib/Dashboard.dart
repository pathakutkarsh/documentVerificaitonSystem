import 'package:document_verification_system/cameraPreview.dart';
import 'package:document_verification_system/constants/colors.dart';
import 'package:document_verification_system/functions/camera.dart';
import 'package:flutter/material.dart';

import 'constants/size.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    availCamera().then((value) => initCamera(value[0]));
  }

  @override
  void dispose() {
    disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        primary: true,
        leading: IconButton(
          iconSize: size_30,
          icon: const Icon(Icons.search_sharp),
          onPressed: () {},
        ),
        actions: const [
          CircleAvatar(
            child: Icon(Icons.face),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              height: screenHeight(context) * 0.2,
              width: screenWidth(context),
              decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(size_12),
                    child: Text(
                      "All Documents",
                      style: TextStyle(fontSize: size_40, color: base),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
        ],
      ),
      bottomSheet: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: base,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(size_50),
                topRight: Radius.circular(size_50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 15,
                )
              ],
            ),
            height: screenHeight(context) * 0.14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.folder_copy_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight(context) * 0.09,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPreiewPage(),
                  ),
                );
              },
              child: Container(
                width: 80,
                height: 80,
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
    );
  }
}
