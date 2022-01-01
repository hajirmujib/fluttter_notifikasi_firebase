import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("message : " +
                  arg[0].toString() +
                  " [1] : " +
                  arg[1].toString()),
            ],
          ),
        ),
      ),
    );
  }
}
