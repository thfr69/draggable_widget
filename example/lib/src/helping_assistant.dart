// import 'package:bubble/bubble.dart';
import 'package:bubble/bubble.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:example/src/helping_assistant_cubit.dart';
import 'package:example/src/helping_assistant_cubit.dart';
import 'package:example/src/speech_bubble_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpingAssistant extends StatefulWidget {

  final HelpingAssistantController? helpingAssistantController;
  final AnchoringPosition initialPosition;

  const HelpingAssistant({this.helpingAssistantController, this.initialPosition = AnchoringPosition.topLeft, Key? key})
      : super(key: key);

  @override
  State<HelpingAssistant> createState() => _HelpingAssistantState();
}

class _HelpingAssistantState extends State<HelpingAssistant> {
  final GlobalKey _bubbleKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();


  late DragController _dragController;


  late Offset _bubbleOffset;
  late Size bubbleSize;
  late Size posSize;

  BubbleNip _bubbleNip = BubbleNip.leftCenter;

  final double _maxWidth = 200;
  final double _minWidth = 100;
  final double _psNowWidth = 150;
  final double _psNowHeight = 150;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dragController = DragController();


    // Size draggableSize = Size(_psNowWidth, _psNowHeight);
    // Size? bubbleSize = _bubbleKey.widgetSize();
    // Size? positionalSize = _positionedKey.widgetSize();
    // print('${draggableSize}');
    // print('${bubbleSize}');
    // print('${positionalSize}');


  }

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpingAssistantCubit, HelpingAssistantState>(
        builder: (context, state) {
          if(state is ControlAssistantVisibilityState) {
            if(state.isVisible) {
              return Stack(
                children: [
                  DraggableWidget(
                    touchDelay: Duration(milliseconds: 100),
                      bottomMargin: 110,
                      topMargin: 0,
                      shadowBorderRadius: 50,
                      normalShadow: const BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 4),
                        blurRadius: 2,
                      ),
                      draggingShadow: BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        offset: const Offset(-10, 5),
                        blurRadius: 10,
                      ),
                      initialPosition: AnchoringPosition.topRight,
                      dragController: _dragController,
                      onTap: widget.helpingAssistantController?.controlSpeechBubbleVisibility,
                      onDraggingCompleted: (anchorPosition, draggableOffset) {
                        Size draggableSize = Size(_psNowWidth, _psNowHeight);
                        Size? bubbleSize = _bubbleKey.widgetSize();
                        Size? positionalSize = _positionedKey.widgetSize();
                        print('${bubbleSize}');
                        print('${positionalSize}');

                        widget.helpingAssistantController?.controlBubblePosition(anchorPosition, draggableOffset, draggableSize, bubbleSize!, positionalSize!);
                      },
                      child: SvgPicture.asset(
                        'assets/icon/ps_now.svg',
                        width: 150,
                        height: 150,
                      )),
                  BlocBuilder<SpeechBubbleCubit, SpeechBubbleState>(
                    builder: (context, state) {
                      bool showBubble = false;
                      if(state is ControlSpeechBubbleState) {
                        showBubble = state.isVisible;
                      }
                      if(state is ControlBubblePositionState) {

                      }
                        return Positioned.directional(
                            key: _positionedKey,
                            textDirection: TextDirection.ltr,
                            // top: state.bubblePosition.dy,
                            // start: state.bubblePosition.dy,
                            top: 200,
                            start: 120,
                            child: Animate(
                              key: _bubbleKey,
                              effects: const [ScaleEffect()],
                              child: showBubble ? Bubble(
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
                              ).animate().scale(delay: 100.ms) : Container(),
                            ));


                    },
                  )
                ],
              );
        }
      }
          return Container();
        }
    );
  }

}

class HelpingAssistantController {
  final BuildContext context;

  HelpingAssistantController(this.context);

  void controlAssistantVisibility() {
    BlocProvider.of<HelpingAssistantCubit>(context).controlAssistantVisibility();
  }

  void controlSpeechBubbleVisibility() {
    print('HelpingAssistantController.controlSpeechBubbleVisibility');
    BlocProvider.of<SpeechBubbleCubit>(context).controlSpeechBubbleVisibility();
  }


  void controlBubblePosition(AnchoringPosition position, Offset draggableOffset, Size draggableSize,
      Size bubbleSize, Size positionalSize) {
    // BlocProvider.of<HelpingAssistantCubit>(context).controlSpeechBubblePosition(
    //     position: position,
    //     draggableOffset: draggableOffset,
    //     draggableSize: draggableSize,
    //     bubbleSize: bubbleSize,
    //     positionalSize: positionalSize);
  }


}

extension GlobalKeyExtension on GlobalKey {
  Size? widgetSize() => currentContext!.size;

  Offset? widgetPosition() {
    final RenderBox? box = currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero);
  }
}
