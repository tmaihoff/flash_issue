import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flash Issue'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showTopFlash(BuildContext context) {
    context.showFlash(
      duration: const Duration(seconds: 5),
      builder: (context, controller) {
        return FlashBar(
          dismissDirections: FlashDismissDirection.values,
          controller: controller,
          position: FlashPosition.top,
          behavior: FlashBehavior.floating,
          content: const Text(
            '🐛 showing flash changes the system navigation bar color to black. It can only be restored when the flash is no longer displayed.',
          ),
        );
      },
    );
  }

  void _showBottomFlash(BuildContext context) {
    context.showFlash(
      duration: const Duration(seconds: 5),
      builder: (context, controller) {
        return FlashBar(
          dismissDirections: FlashDismissDirection.values,
          controller: controller,
          behavior: FlashBehavior.floating,
          content: const Text(
            'Bottom flash works fine',
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setSystemUIOverlayStyleAndMode();
  }

  void _setSystemUIOverlayStyleAndMode() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.green,
        systemNavigationBarContrastEnforced: false,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: _setSystemUIOverlayStyleAndMode,
              child: const Text(
                'Restore System Navigation Bar Color',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () => _showTopFlash(context),
            icon: const Icon(Icons.bug_report_outlined),
            label: const Text('Release the Bug'),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: () => _showBottomFlash(context),
            icon: const Icon(Icons.check),
            label: const Text('Bottom Flash'),
          )
        ],
      ),
    );
  }
}
