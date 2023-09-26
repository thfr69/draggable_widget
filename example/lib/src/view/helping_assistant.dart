import 'package:draggable_widget/draggable_widget.dart';
import 'package:example/src/view/widget/speech_bubble_edges.dart';
import 'package:example/src/view/widget/speech_bubble_widget.dart';
import 'package:example/src/view_model/helping_assistant_cubit.dart';
import 'package:example/src/view_model/speech_bubble_cubit.dart';
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
  final GlobalKey _positionedKey = GlobalKey();


  late DragController _dragController;

  late Size bubbleSize;
  late Size posSize;

  final double _maxWidth = 200;
  final double _minWidth = 100;
  final double _psNowWidth = 150;
  final double _psNowHeight = 150;

  late AnchoringPosition currentDocker;

  late bool isBubbleShowing;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dragController = DragController();

  }


  @override
  void initState() {
    super.initState();

    currentDocker = widget.initialPosition;

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
                      initialPosition: widget.initialPosition,
                      dragController: _dragController,
                      onTap: () {
                        widget.helpingAssistantController?.controlSpeechBubbleVisibility();
                      },
                      onDraggingCompleted: (anchorPosition, draggableOffset) {
                        Size draggableSize = Size(_psNowWidth, _psNowHeight);
                        Size? positionalSize =  _positionedKey.widgetSize();
                        widget.helpingAssistantController?.controlSpeechBubbleVisibility(hideTemporarily: false);
                        widget.helpingAssistantController?.controlBubblePosition(anchorPosition, draggableOffset, draggableSize, positionalSize!);
                      },
                      onDraggingStarted: () {
                        widget.helpingAssistantController?.controlSpeechBubbleVisibility(hideTemporarily: true);
                      },
                      child: SvgPicture.asset(
                        'assets/icon/ps_now.svg',
                        width: 150,
                        height: 150,
                      )),
                  BlocBuilder<SpeechBubbleCubit, ControlSpeechBubbleState>(
                    builder: (context, state) {
                        return Positioned.directional(
                            key: _positionedKey,
                            textDirection: TextDirection.ltr,
                            top: state.bubblePosition.dy,
                            start: state.bubblePosition.dx,
                              child: Opacity(
                                opacity: state.isVisible ? 1 : 0,
                                child: Animate(
                                  child: SpeechBubbleWidget(
                                    margin: const SpeechBubbleEdges.only(top: 10),
                                    nipWidth: 8,
                                    nipHeight: 24,
                                    nip: state.bubbleNip,
                                    color: const Color.fromRGBO(225, 255, 199, 1.0),
                                    child: Container(
                                      constraints: BoxConstraints(minWidth: _minWidth, maxWidth: _maxWidth),
                                      child: Animate(
                                        effects: const [FadeEffect()],
                                        child: Text(
                                          'Lorem ipsum dolor sit amet, ut aperiri euripidis vim, minimum eligendi tractatos ius ei.',
                                          style: const TextStyle(fontSize: 20),
                                        ).animate(target: state.isVisible ? 1 : 0).fadeIn(delay: 400.ms),
                                      ),
                                      // child: Text('Lorem ipsum dolor ', style: TextStyle(fontSize: 20),)
                                    ),
                                  ).animate(target: state.isVisible ? 1 : 0).fadeIn(delay: 200.ms),
                                )
                        )
                        );
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

  void controlSpeechBubbleVisibility({bool? hideTemporarily}) {
    BlocProvider.of<SpeechBubbleCubit>(context).controlSpeechBubbleVisibility(hideTemporarily: hideTemporarily);
  }



  void controlBubblePosition(AnchoringPosition position, Offset draggableOffset, Size draggableSize, Size positionalSize) {

    BlocProvider.of<SpeechBubbleCubit>(context).controlSpeechBubblePosition(
        docker: position,
        draggableOffset: draggableOffset,
        draggableSize: draggableSize,
        positionalSize: positionalSize);
  }

}

extension GlobalKeyExtension on GlobalKey {
  Size? widgetSize()  {
    final RenderBox? box = currentContext?.findRenderObject() as RenderBox?;
    return box?.size;
  }

  Offset? widgetPosition() {
    final RenderBox? box = currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero);
  }
}
