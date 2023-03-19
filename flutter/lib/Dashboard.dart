import 'package:document_verification_system/constants/colors.dart';
import 'package:flutter/material.dart';

import 'constants/size.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight(context) * 0.3,
            decoration: const BoxDecoration(
                color: primary,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
          ),
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
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
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
              onTap: () {},
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 5),
                        color: primary.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 15,
                      )
                    ]),
                child: const Icon(
                  Icons.add,
                  size: 50,
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
