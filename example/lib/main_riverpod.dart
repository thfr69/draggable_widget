import 'package:bubble/bubble.dart';
import 'package:example/src/view/riverpod_helping_assistant.dart';
import 'package:example/src/view_model/speech_bubble_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));


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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testpage - PS-Now Helper with RiverPod'),
        actions: [
          Consumer(builder: (context, ref, child) => IconButton(onPressed: () => _onPressed(ref), icon: const Icon(Icons.live_help_outlined)))
        ],
      ),
      body: Stack(
        children: <Widget>[
        RiverPodHelpingAssistant(helpingAssistantController: RiverPodHelpingAssistantController(),),
      ]),
    );
  }

  void _onPressed(WidgetRef ref) {
/*    bool isVisible = ref.read(assistantVisibilityProvider);
    print('${isVisible}');
    ref.read(assistantVisibilityProvider.notifier).state = !isVisible;*/
    ref.read(assistantVisibilityProvider.notifier).state = !ref.read(assistantVisibilityProvider);
  }
}




