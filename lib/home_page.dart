import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service = FlutterBackgroundService();

  String _name = 'Stop service';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Back-Ground Services"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsForeground');
              },
              child: const Text("Foreground Service"),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsBackground');
              },
              child: const Text("Background Service"),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke('stopSelf');
                } else {
                  service.startService();
                }

                if (!isRunning) {
                  _name = 'Stop service';
                } else {
                  _name = 'Start service';
                }

                setState(() {});
              },
              child: Text(_name),
            ),
          ],
        ),
      ),
    );
  }
}
