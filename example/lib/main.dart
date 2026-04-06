import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apphud_push_notifications/apphud_push_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status =
      'Call after `Apphud.start()` from the main apphud package. Then register for APNs.';
  final _plugin = ApphudPushNotifications();

  Future<void> _registerPush() async {
    try {
      await _plugin.registerForPushNotifications();
      if (!mounted) return;
      setState(() {
        _status = 'registerForPushNotifications completed.';
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        _status = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('apphud_push_notifications')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_status, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _registerPush,
                  child: const Text('Register for push (Apphud)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
