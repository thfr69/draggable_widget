import 'package:bubble/bubble.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:example/src/model/speech_bubble.dart';
import 'package:example/src/view/helping_assistant.dart';
import 'package:example/src/view/widget/speech_bubble.export.dart';
import 'package:example/src/view_model/speech_bubble_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiverPodHelpingAssistant extends ConsumerStatefulWidget {
  final RiverPodHelpingAssistantController? helpingAssistantController;
  final AnchoringPosition initialPosition;

  const RiverPodHelpingAssistant(
      {this.helpingAssistantController, this.initialPosition = AnchoringPosition.topLeft, Key? key})
      : super(key: key);

  @override
  ConsumerState<RiverPodHelpingAssistant> createState() => _RiverPodHelpingAssistantState();
}

class _RiverPodHelpingAssistantState extends ConsumerState<RiverPodHelpingAssistant> {
  final GlobalKey _bubbleKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();
  final GlobalKey _placeHolderKey = GlobalKey();

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
    // print('_HelpingAssistantState.didChangeDependencies');

    _dragController = DragController();
  }

/*  @override
  void didUpdateWidget(HelpingAssistant oldWidget) {
    print('_HelpingAssistantState.didUpdateWidget');

    super.didUpdateWidget(oldWidget);
  }*/

  @override
  void initState() {
    super.initState();

    currentDocker = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    bool assistantVisible = ref.watch(assistantVisibilityProvider);
    bool bubbleVisible = ref.watch(bubbleVisibilityProvider) as bool;
    SpeechBubble state = ref.watch(speechBubbleProvider) as SpeechBubble;

    return Stack(
      children: [
        assistantVisible
            ? DraggableWidget(
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
                initialPosition: currentDocker,
                dragController: _dragController,
                onTap: () {
                  ref.read(bubbleVisibilityProvider.notifier).state = !ref.read(bubbleVisibilityProvider.notifier).state;
                },
                onDraggingCompleted: (anchorPosition, draggableOffset) {
                  currentDocker = anchorPosition;
                  Size draggableSize = Size(_psNowWidth, _psNowHeight);
                  Size? positionalSize = _positionedKey.widgetSize();
                  ref.read(speechBubbleProvider.notifier).refreshSpeechBubble(anchorPosition, draggableOffset, draggableSize, positionalSize!);
                  ref.read(bubbleVisibilityProvider.notifier).controlBubbleVisibility(hideTemporarily: false);
                },
                onDraggingStarted: () {
                  ref.read(bubbleVisibilityProvider.notifier).controlBubbleVisibility(hideTemporarily: true);
                },
                child: SvgPicture.asset(
                  'assets/icon/ps_now.svg',
                  width: 150,
                  height: 150,
                ))
            : Container(),
        Positioned.directional(
            key: _positionedKey,
            textDirection: TextDirection.ltr,
            top: state.bubbleOffset.dy,
            start: state.bubbleOffset.dx,
            child: Opacity(
              opacity: bubbleVisible ? 1 : 0,
              // child: Container(width: 300, height: 300, color: Colors.pink.withOpacity(0.1),)
              child: Animate(
                // key: _bubbleKey,
                effects: const [ScaleEffect()],
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
                      ).animate(target: ref.read(bubbleVisibilityProvider.notifier).state ? 1 : 0).fadeIn(delay: 400.ms),

                    ),
                    // child: Text('Lorem ipsum dolor ', style: TextStyle(fontSize: 20),)
                  ),
                ).animate(target: ref.read(bubbleVisibilityProvider.notifier).state ? 1 : 0).fadeIn(delay: 200.ms),
              ),
            )),
      ],
    );
  }
}

class RiverPodHelpingAssistantController {
  RiverPodHelpingAssistantController();

  void controlAssistantVisibility() {}

  void controlSpeechBubbleVisibility() {}

/*  void controlBubblePosition(AnchoringPosition position, Offset draggableOffset, Size draggableSize,
      */ /*Size bubbleSize, */ /*Size positionalSize) {

    BlocProvider.of<SpeechBubbleCubit>(context).controlSpeechBubblePosition(
        docker: position,
        draggableOffset: draggableOffset,
        draggableSize: draggableSize,
*/ /*        bubbleSize: bubbleSize,*/ /*
        positionalSize: positionalSize);
  }*/
}
