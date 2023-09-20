import 'package:draggable_widget/draggable_widget.dart';
import 'package:example/src/helping_assistant.dart';
import 'package:example/src/helping_assistant_cubit.dart';
import 'package:example/src/speech_bubble_cubit.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<HelpingAssistantCubit>(create: (context) => HelpingAssistantCubit()),
        BlocProvider<SpeechBubbleCubit>(create: (context) => SpeechBubbleCubit()),
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
      body: Stack(
        children: <Widget>[
          HelpingAssistant(helpingAssistantController: controller,),
          // DraggableWidget(
          //   bottomMargin: 40,
          //   topMargin: 80,
          //   // initialVisibility: true,
          //   horizontalSpace: 0,
          //   shadowBorderRadius: 50,
          //   child: SvgPicture.asset(
          //     'assets/icon/ps_now.svg',
          //     width: 150,
          //     height: 150,
          //   ),
          //   initialPosition: AnchoringPosition.topRight,
          //   // dragController: dragController,
          // )
        ],
      ),
    );

  }

  void _onPressed() {
    controller.controlAssistantVisibility();
  }
}
