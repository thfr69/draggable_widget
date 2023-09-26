import 'package:example/src/custom_animated_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OverlayExample(),
    );
  }
}

class OverlayExample extends StatefulWidget {
  const OverlayExample({Key? key}) : super(key: key);

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample> {
  final CustomAnimatedOverlay overlay = CustomAnimatedOverlay(
    const Duration(
      milliseconds: 200,
    ),
  );

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Overlay'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_count',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOverlay,
        tooltip: 'Add Overlay',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addOverlay() {
    final child = DraggableCard(
      overlayController: overlay,
      onTap: _incrementCount,
    );

    overlay.insert(context, child: child);
  }

  void _incrementCount() {
    _count++;
    setState(() {});
  }
}

class DraggableCard extends StatelessWidget {
  final VoidCallback? onTap;
  final CustomAnimatedOverlay overlayController;
  DraggableCard({
    Key? key,
    this.onTap,
    required this.overlayController,
  }) : super(key: key);

  late Offset currentOffset;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
          'assets/icon/ps_now.svg',
          width: 150,
          height: 150,
        ),
      onPanUpdate: (details) {
        currentOffset = details.globalPosition;
        overlayController.alignChildTo(details.globalPosition, size * 0.5);
      },
      onPanEnd: (_) {
        print('currentOffset ${currentOffset}');
        // overlayController.alignToScreenEdge();
      },
    );
  }
}
