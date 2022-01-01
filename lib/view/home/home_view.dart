import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notif_pusher/view/home/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () {
              controller.refreshToken();
            }),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Notification Pusher"),
        ),
      ),
    );
  }
}
