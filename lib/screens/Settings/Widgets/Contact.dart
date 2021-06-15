import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.065,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'contact'.tr,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.email),
                onPressed: () => HelpFunctions.launchUrl(),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}