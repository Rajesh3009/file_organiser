import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dir = [];

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Access files here
      dir = await listDirectories("storage/emulated/0/");
      dir.forEach((element) {
        log(element);
      });
    } else if (status.isDenied) {
      // Handle denied permission
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied permission (open app settings)
    }
  }

  Future<List<String>> listDirectories(String path) async {
    final directory = Directory(path);
    final subDirs = directory.list();
    return subDirs
        .where((entity) => entity is Directory)
        .map((e) => e.path)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: SafeArea(
        child: Column(
          children: [Text("Hello World")],
        ),
      ),
    );
  }
}
