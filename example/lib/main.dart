import 'package:draggable_widget/draggable_widget.dart';
import 'package:example/src/view/helping_assistant.dart';
import 'package:example/src/view_model/helping_assistant_cubit.dart';
import 'package:example/src/view_model/speech_bubble_cubit.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<HelpingAssistantCubit>(create: (context) => HelpingAssistantCubit()),
        // BlocProvider<SpeechBubbleCubit>(create: (context) => SpeechBubbleCubit()),
      ],


      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Beispiel',),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HelpingAssistantController controller;

  late double psNowWidth;
  late double psNowHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = HelpingAssistantController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Testpage - PS-Now Helper'),
          actions: [
            IconButton(onPressed: _onPressed, icon: const Icon(Icons.live_help_outlined))
          ],
        ),
        body: SafeArea(child: HelpingAssistant(child: SubPage(), helpingAssistantController: controller,))
      // body: ,

    );
  }

  void _onPressed() {
    // controller.controlAssistantVisibility();
    BlocProvider.of<HelpingAssistantCubit>(context).controlAssistantVisibility(showBubbleAsWell: true);
  }
}

class SubPage extends StatelessWidget {
  const SubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellowAccent, child: ListView(
      children: List<String>.generate(20, (index) => 'Zeile $index').map((e) => ListTile(title: Text(e),)).toList(),
    ),);
  }
}

