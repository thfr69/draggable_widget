import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final double _maxWidth = 200;

  final double _minWidth = 100;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Animate(
          controller: _animationController,
          effects: const [ScaleEffect()],
          child: Bubble(
            margin: const BubbleEdges.only(top: 10),
            nipWidth: 8,
            nipHeight: 24,
            nip: BubbleNip.leftCenter,
            // nip: BubbleNip.leftCenter,
            color: const Color.fromRGBO(225, 255, 199, 1.0),
            child: Container(
              constraints: BoxConstraints(minWidth: _minWidth, maxWidth: _maxWidth),
              child: Animate(
                effects: const [FadeEffect()],
                child: Text(
                  'Lorem ipsum dolor sit amet, ut aperiri euripidis vim, minimum eligendi tractatos ius ei.',
                  style: const TextStyle(fontSize: 20),
                ).animate().fadeIn(delay: 500.ms),
              ),
              // child: Text('Lorem ipsum dolor ', style: TextStyle(fontSize: 20),)
            ),
          ).animate().scale(delay: 100.ms)),
      ),
    );
  }


}
